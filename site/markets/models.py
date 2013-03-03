 # -*- coding: utf-8 -*-

from google.appengine.ext import db


class Market(db.Model):
    ref = db.IntegerProperty()
    datetime = db.DateTimeProperty(auto_now_add=False)
    exchange_rate = db.FloatProperty(default=1.0)


class StockName(db.Model):
    market_ref = db.IntegerProperty()
    code = db.StringProperty()
    name = db.StringProperty()


class Stock(db.Model):
    market = db.ReferenceProperty(Market, collection_name="stocks")
    value = db.FloatProperty()
    name = db.ReferenceProperty(StockName)
    diff = db.FloatProperty()


def clear_db():
    db.delete(Stock.all(keys_only=True).fetch(1000))
    db.delete(Market.all(keys_only=True).fetch(1000))
    db.delete(StockName.all(keys_only=True).fetch(1000))
