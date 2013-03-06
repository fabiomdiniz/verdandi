 # -*- coding: utf-8 -*-

from google.appengine.api import urlfetch

from bs4 import BeautifulSoup

from models import Stock, Market
import util
import json
import datetime


def get_datetime():
    url = 'http://www.worldweatheronline.com/feed/tz.ashx?key=a730d81bdf185251132302&q=New+York&format=json'
    time_str = json.loads(urlfetch.fetch(url, deadline=30).content)['data']['time_zone'][0]['localtime']
    return datetime.datetime.strptime(time_str, '%Y-%m-%d %H:%M')


def get_market():
    #util.clean_market(2)
    dt = get_datetime()
    market = Market(ref=2, date=dt.date(), time=dt.time())
    market.put()

    url = 'http://www.barchart.com/stocks/dowcomp.php?view=main'
    soup = BeautifulSoup(urlfetch.fetch(url, deadline=30).content, 'lxml')
    table = soup('table', attrs={'id': 'dt1'})[0]

    for tr in table('tr')[1:]:
        tds = tr('td')
        code = str(tds[0].text)
        name = str(tds[1].text)
        value = float(tds[2].text.replace(',', ''))
        text_replace = tds[4].text.replace(',', '').replace('%', '')
        diff = float(text_replace) if text_replace != 'unch' else 0.0
        stock = Stock(name=util.get_or_create_name(2, code, name),
                      value=value, diff=diff, market=market.key())
        stock.put()
