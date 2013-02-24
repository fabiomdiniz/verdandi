 # -*- coding: utf-8 -*-

from google.appengine.ext import db

from markets.models import StockName
import markets.util
import game.util

PLAYERS = (
    'Human',
    'Verdandi'
    )


class Match(db.Model):
    date = db.DateProperty(auto_now_add=True)
    user = db.UserProperty(auto_current_user_add=True)

    player = db.IntegerProperty(default=0)

    money_available = db.FloatProperty(default=100000)

    mtm_today = db.FloatProperty(default=100000)
    mtm_yesterday = db.FloatProperty(default=100000)

    easy_mode = db.BooleanProperty(default=False)

    market_ref = db.IntegerProperty(default=-1)  # Default to all markets

    def calc_mtm(self):
        mtm = 0.0
        exchange_rate = game.util()
        for asset in self.assets:
            stock = markets.util.get_stock(asset.name)
            mtm_asset = stock.value * asset.shares
            if asset.market_ref == 0:  # If it is Brazil I need to convert to dollars
                mtm_asset /= exchange_rate
            mtm += mtm_asset
        return mtm

    def refresh_mtm(self):
        self.mtm_yesterday = self.mtm_today
        self.mtm_today = self.calc_mtm()

    def buy_sell_asset(self, ref, share_code, num_shares):
        stock_name = markets.util.get_stock_name(ref, share_code)
        stock_name_key = stock_name.key()
        asset_lst = Asset.all()
        asset_lst.filter('market_ref = ', ref)
        asset_lst.filter('name = ', stock_name_key).fetch(1)
        if asset_lst:  # Asset exists!
            asset_lst[0].shares += num_shares
            if asset_lst[0].shares:
                asset_lst[0].put()
            else:  # Asset vanished!
                asset_lst[0].delete()
        else:  # New asset!
            asset = Asset(match=self.key(), market_ref=ref,
                 name=stock_name_key, shares=num_shares)
            asset.put()
        stock = markets.util.get_stock(stock_name)
        self.money_available += stock.value * num_shares


class Asset(db.Model):
    match = db.ReferenceProperty(Match, collection_name="assets")
    market_ref = db.IntegerProperty()
    name = db.ReferenceProperty(StockName)
    shares = db.IntegerProperty()
