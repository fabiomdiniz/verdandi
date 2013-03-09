 # -*- coding: utf-8 -*-
from google.appengine.ext import db
from google.appengine.api import urlfetch

from datetime import datetime, time, timedelta


from models import Stock, Market, StockName


def get_exchange():
    url = 'http://download.finance.yahoo.com/d/quotes.csv?s=USDBRL=X&f=sl1&e=.csv'
    return float(urlfetch.fetch(url, deadline=30).content.split(',')[-1].rstrip())


def last_weekdays(num):
    out = [prev_weekday(today_date())]
    for i in range(1, num):
        out.append(prev_weekday(out[i-1]))
    return out


def prev_weekday(adate):
    adate -= timedelta(days=1)
    while adate.weekday() > 4:  # Mon-Fri are 0-4
        adate -= timedelta(days=1)
    return adate


def clean_string(string):
    return ' '.join([b for b in string.replace('\r', '').replace('\n', '').split(' ') if b])


def get_float(string):
    return float(string.replace(',', '.'))


def today_date():
    return datetime.combine(datetime.today().date(), time())


def last_date():
    day_delta = 0  # TODO
    hours_delta = 0  # TODO
    return datetime.combine((datetime.today() - timedelta(days=day_delta, hours=hours_delta)).date(), time())


def get_market(ref, date=None, keys_only=False):
    if date is None:
        return Market.all(keys_only=keys_only).filter("ref =", ref).order('-date').order('-time').get()
    else:
        return Market.all(keys_only=keys_only).filter("date =", date.date()).filter("time =", date.time()).filter("ref =", ref).get()


def get_stock(stock_name, date=None):
    market = get_market(stock_name.market_ref, date, keys_only=True)
    return Stock.all().filter("market =", market).filter('name = ', stock_name.key()).get()


def get_stocks_days(stock_name, num_days=10):
    days = last_weekdays(num_days)
    out = []
    for day in days:
        market = Market.all(keys_only=False).filter("date =", day.date()).filter("ref =", stock_name.market_ref).order('-time').get()
        if not market is None:
            stock = Stock.all().filter("market =", market.key()).filter('name = ', stock_name.key()).get()
            if not stock is None:
                out.append((day, stock, market.exchange_rate))
    return out


def get_stocks_in_day(stock_name, day):
    out = []
    markets = Market.all(keys_only=False).filter("date =", day.date()).filter("ref =", stock_name.market_ref).order('-time').fetch(100)
    for market in markets:
        stock = Stock.all().filter("market =", market.key()).filter('name = ', stock_name.key()).get()
        if not stock is None:
            dt = datetime.combine(market.date, market.time)
            out.append((dt, stock, market.exchange_rate))
    return out


def get_stock_name(ref, stock_code, keys_only=False):
    return StockName.all(keys_only=keys_only).filter("market_ref = ", ref).filter("code =", stock_code).get()


def clean_market(ref, date=None):
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
