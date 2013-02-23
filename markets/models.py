from google.appengine.ext import db
from google.appengine.api import users

import brazil

MARKETS = (
    ('BMFBovespa', brazil),
    )

class Market(db.Model):
    ref = db.IntegerProperty()
    date = db.DateProperty(auto_now_add=True)

class StockName(db.Model):
    market_ref = db.IntegerProperty()
    code = db.StringProperty()
    name = db.StringProperty()

class Stock(db.Model):
    market = db.ReferenceProperty(Market, collection_name = "stocks")
    value = db.FloatProperty()
    name = db.ReferenceProperty(StockName)
    diff = db.FloatProperty()