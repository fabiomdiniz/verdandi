 # -*- coding: utf-8 -*-

from bs4 import BeautifulSoup
from models import Stock, Market
import util
from google.appengine.api import urlfetch


def get_market():
    util.clean_market(0)
    url = 'http://pregao-online.bmfbovespa.com.br/Cotacoes.aspx'
    soup = BeautifulSoup(urlfetch.fetch(url, deadline=30).content, 'lxml')

    market = Market()
    market.ref = 0
    market.put()

    table = soup('table', attrs={'id': 'ctl00_DefaultContent_GrdCarteiraIndice'})[0]
    for tr in table('tr')[1:]:
        tds = tr('td')
        code = str(tds[0].string)
        name = util.clean_string(tds[1].string)
        value = util.get_float(tds[2].string)
        diff = util.get_float(tds[3].text.strip())
        stock = Stock(name=util.get_or_create_name(0, name, code),
                      value=value, diff=diff, market=market.key())
        stock.put()
