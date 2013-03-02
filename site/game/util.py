 # -*- coding: utf-8 -*-

from google.appengine.api import urlfetch


def get_exchange():
    url = 'http://download.finance.yahoo.com/d/quotes.csv?s=USDBRL=X&f=sl1&e=.csv'
    return float(urlfetch.fetch(url, deadline=30).content.split(',')[-1].rstrip())


def valid_match(data):
    return True
