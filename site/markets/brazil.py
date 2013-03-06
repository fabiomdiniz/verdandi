 # -*- coding: utf-8 -*-

from models import Stock, Market

from bs4 import BeautifulSoup

import util
import json
import datetime
from google.appengine.api import urlfetch


def get_datetime():
    url = 'http://www.worldweatheronline.com/feed/tz.ashx?key=a730d81bdf185251132302&q=Sao+Paulo&format=json'
    time_str = json.loads(urlfetch.fetch(url, deadline=30).content)['data']['time_zone'][0]['localtime']
    return datetime.datetime.strptime(time_str, '%Y-%m-%d %H:%M')


def get_market():
    #util.clean_market(0)
    url = 'http://pregao-online.bmfbovespa.com.br/Cotacoes.aspx'
    soup = BeautifulSoup(urlfetch.fetch(url, deadline=30).content, 'lxml')
    rate = util.get_exchange()
    dt = get_datetime()
    market = Market(ref=0, date=dt.date(), time=dt.time(), exchange_rate=rate)
    market.put()

    table = soup('table', attrs={'id': 'ctl00_DefaultContent_GrdCarteiraIndice'})[0]
    for tr in table('tr')[1:]:
        tds = tr('td')
        code = str(tds[0].string)
        name = util.clean_string(tds[1].string)
        value = util.get_float(tds[2].string)
        diff = util.get_float(tds[3].text.strip())
        stock = Stock(name=util.get_or_create_name(0, code, name),
                      value=value, diff=diff, market=market.key())
        stock.put()
