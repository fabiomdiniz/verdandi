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
    #util.clean_market(1)
    dt = get_datetime()
    market = Market(ref=1, date=dt.date(), time=dt.time())
    market.put()

    url = 'http://www.barchart.com/stocks/nasdaq100.php?view=main'
    soup = BeautifulSoup(urlfetch.fetch(url, deadline=30).content, 'lxml')
    table = soup('table', attrs={'id': 'dt1'})[0]

    for tr in table('tr')[1:]:
        tds = tr('td')
        code = str(tds[0].text)
        name = str(tds[1].text)
        value = float(tds[2].text.replace(',', ''))
        text_replace = tds[4].text.replace(',', '').replace('%', '')
        diff = float(text_replace) if text_replace != 'unch' else 0.0
        stock = Stock(name=util.get_or_create_name(1, code, name),
                      value=value, diff=diff, market=market.key())
        stock.put()


#def get_stock_codes():
#    url = 'http://www.nasdaq.com/screening/companies-by-name.aspx?letter=0&exchange=nasdaq&render=download'
#    c = urlfetch.fetch(url, deadline=30).content
#    return [map(lambda x: x.replace('"', ''), b.split(',')[0:2]) for b in c.split('\r\n')[1:] if b]
#
#
#def get_full_market():
#    """ Deprecated for now, too many stocks (> 2000) makes it too slow"""
#    util.clean_market(1)
#    codes = get_stock_codes()
#
#    market = Market(ref=1)
#    market.put()
#
#    for code in codes:
#        url = 'http://finance.google.com/finance/info?client=ig&q=NASDAQ%3a{}'.format(code[0])
#        response = urlfetch.fetch(url, deadline=30).content
#        try:
#            info = json.loads(response.replace('\n', '').replace('//', '').strip())[0]
#        except Exception as e:
#            logging.error('Coult not fetch {} - error: {}'.format(code[0], repr(e)))
#        else:
#            diff = float(info['cp'].replace(',', '')) if info['cp'] else 0.0
#            value = float(info['l'].replace(',', '')) if info['l'] else 0.0
#            stock = Stock(name=util.get_or_create_name(1, *code),
#                          value=value, diff=diff, market=market.key())
#            stock.put()
#            logging.info('Fetched {}'.format(code[0]))
