 # -*- coding: utf-8 -*-

from google.appengine.ext import db

from markets.models import StockName
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

    def calc_mtm(self):
        mtm = 0.0
        for asset in self.assets:
            stock = markets.util.get_stock(asset.name)
            mtm_asset = stock.value * asset.shares
            if asset.name.market_ref == 0:  # If it is Brazil I need to convert to dollars
                mtm_asset /= stock.market.exchange_rate
            mtm += mtm_asset
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
            import logging
            asset = asset_lst[0]
            logging.error(asset)
            logging.error(num_shares)
            logging.error(asset.shares)
            asset.shares += num_shares
            logging.error(asset.shares)
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


class Asset(db.Model):
    match = db.ReferenceProperty(Match, collection_name="assets")
    name = db.ReferenceProperty(StockName)
    shares = db.IntegerProperty()


def clear_db():
    db.delete(Match.all(keys_only=True).fetch(1000))
    db.delete(Asset.all(keys_only=True).fetch(1000))
