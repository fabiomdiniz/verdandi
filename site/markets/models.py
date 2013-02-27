 # -*- coding: utf-8 -*-

from google.appengine.ext import db


class Market(db.Model):
    ref = db.IntegerProperty()
    datetime = db.DateTimeProperty(auto_now_add=False)


class StockName(db.Model):
    market_ref = db.IntegerProperty()
    code = db.StringProperty()
    name = db.StringProperty()


class Stock(db.Model):
    market = db.ReferenceProperty(Market, collection_name="stocks")
    value = db.FloatProperty()
    name = db.ReferenceProperty(StockName)
    diff = db.FloatProperty()
