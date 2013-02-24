 # -*- coding: utf-8 -*-

from google.appengine.api import urlfetch

from bs4 import BeautifulSoup

from models import Stock, Market
import util


def get_market():
    util.clean_market(2)

    market = Market(ref=2)
    market.put()

    url = 'http://www.barchart.com/stocks/dowcomp.php?view=main'
    soup = BeautifulSoup(urlfetch.fetch(url, deadline=30).content, 'lxml')
    table = soup('table', attrs={'id': 'dt1'})[0]

    for tr in table('tr')[1:]:
        tds = tr('td')
        code = str(tds[0].text)
        name = str(tds[1].text)
        value = float(tds[2].text.replace(',', ''))
        diff = float(tds[4].text.replace(',', '').replace('%', ''))
        stock = Stock(name=util.get_or_create_name(2, code, name),
                      value=value, diff=diff, market=market.key())
        stock.put()
