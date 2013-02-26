 # -*- coding: utf-8 -*-
from google.appengine.ext import db
from datetime import datetime, time, timedelta
from models import Stock, Market, StockName


def clean_string(string):
    return ' '.join([b for b in string.replace('\r', '')
                                 .replace('\n', '')
                                 .split(' ') if b])


def get_float(string):
    return float(string.replace(',', '.'))


def today_date():
    return datetime.combine(datetime.today().date(), time())


def last_date():
    day_delta = 0  # TODO
    hours_delta = 0  # TODO
    return datetime.combine((datetime.today() - timedelta(days=day_delta, hours=hours_delta)).date(), time())


def get_market(ref, date=last_date(), keys_only=False):
    return Market.all(keys_only=keys_only).filter("date =", date).filter("ref =", ref).get()


def get_stock(stock_name, date=last_date()):
    market = get_market(stock_name.market_ref, date, keys_only=True)
    return Stock.all().filter("market =", market).filter('name = ', stock_name.key()).get()


def get_stock_name(ref, stock_code, keys_only=False):
    return StockName.all(keys_only=keys_only).filter("market_ref = ", ref).filter("code =", stock_code).get()


def clean_market(ref, date=last_date()):
    market = get_market(ref, date, keys_only=True)
    if market:
        db.delete(Stock.all(keys_only=True).filter("market =", market).fetch(1000))
        db.delete(market)


def get_or_create_name(ref, code, name):
    name_list = StockName.all(keys_only=True).filter("market_ref = ", ref).filter("code =", code).fetch(1)
    if name_list:
        return name_list[0]
    else:
        s = StockName(code=code, name=name, market_ref=ref)
        s.put()
        return s.key()


def clear_db():
    db.delete(Stock.all(keys_only=True).fetch(1000))
    db.delete(Market.all(keys_only=True).fetch(1000))
    db.delete(StockName.all(keys_only=True).fetch(1000))
