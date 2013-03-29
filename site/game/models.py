 # -*- coding: utf-8 -*-

from google.appengine.ext import db

from markets.models import StockName, Stock
import markets.util

PLAYERS = (
    'Human',
    'Verdandi'
)


class Match(db.Model):
    date = db.DateProperty(auto_now_add=True)
    user = db.UserProperty(auto_current_user_add=True)

    player = db.IntegerProperty(default=0)

    money_available = db.FloatProperty(default=10000.0)

    mtm_now = db.FloatProperty(default=10000.0)
    mtm_before = db.FloatProperty(default=10000.0)

    easy_mode = db.BooleanProperty(default=False)

    market_refs = db.StringProperty()  # Default to all markets

    def get_perc(self):
        return (self.mtm_now - self.mtm_before) / self.mtm_before if self.mtm_before else 0.0

    def calc_mtm(self):
        mtm = 0.0
        stocks_list = []
        for asset in self.assets:
            stock = markets.util.get_stock(asset.name)
            mtm_asset = stock.value * asset.shares
            stocks_list.append((stock, asset.shares))
            if asset.name.market_ref == 0:  # If it is Brazil I need to convert to dollars
                mtm_asset /= stock.market.exchange_rate
            mtm += mtm_asset
        self.save_history(stocks_list, mtm, self.money_available)
        return mtm + self.money_available

    def refresh_mtm(self):
        self.mtm_before = self.mtm_now
        self.mtm_now = self.calc_mtm()
        self.put()

    def buy_sell_asset_keys(self, keys, lst_num_shares):
        shares = db.Model.get(keys)
        for share, num_shares in zip(shares, lst_num_shares):
            self.buy_sell_asset(share, num_shares)

    def buy_sell_asset(self, stock_name, num_shares):
        stock_name_key = stock_name.key()
        ref = stock_name.market_ref
        asset_lst = Asset.all().filter('match = ', self.key())
        asset_lst.filter('name = ', stock_name_key).fetch(1)
        if asset_lst.count():  # Asset exists!
            asset = asset_lst[0]
            asset.shares += num_shares
            if asset.shares > 0:
                asset.put()
            else:  # Asset vanished!
                asset.delete()
        else:  # New asset!
            asset = Asset(match=self.key(),
                          name=stock_name_key, shares=num_shares)
            asset.put()
        stock = markets.util.get_stock(stock_name)
        ammount = stock.value * num_shares
        if ref == 0:  # If it is Brazil I need to convert to dollars
            ammount /= stock.market.exchange_rate
        self.money_available -= ammount
        self.put()

    def sell_everything(self):
        for asset in self.assets:
            self.buy_sell_asset(asset.name, -1*asset.shares)

    def save_history(self, stocks_list, mtm, money):
        history = MatchHistory(match=self.key(), mtm=mtm, money=money)
        history.put()
        for stock, shares in stocks_list:
            AssetHistory(match=history.put(), stock=stock, shares=shares).put()


class Asset(db.Model):
    match = db.ReferenceProperty(Match, collection_name="assets")
    name = db.ReferenceProperty(StockName)
    shares = db.IntegerProperty()


class MatchHistory(db.Model):
    datetime = db.DateTimeProperty(auto_now_add=True)
    match = db.ReferenceProperty(Match, collection_name="history")
    mtm = db.FloatProperty()
    money = db.FloatProperty()


class AssetHistory(db.Model):
    match = db.ReferenceProperty(MatchHistory, collection_name="assets")
    stock = db.ReferenceProperty(Stock)
    shares = db.IntegerProperty()


def clear_db():
    db.delete(Match.all(keys_only=True).fetch(1000))
    db.delete(Asset.all(keys_only=True).fetch(1000))
