 # -*- coding: utf-8 -*-

from bottle import route, request

import json
import calendar
import datetime

from markets import MARKETS
import markets.views
import markets.util
import markets.models
import game.gameflow
import game.util
import game.models


def get_stamp(date_obj):
    return calendar.timegm(date_obj.timetuple())*1000


@route('/api/stockname')
def api_stockname():
    names = markets.models.StockName.all().filter('market_ref IN', map(int, request.query.markets.split(';'))).fetch(5000)
    return json.dumps([' - '.join([MARKETS[s.market_ref][0] + ':' + s.code, s.name]) for s in names])


def stockprice(stock_name):
    stock = markets.util.get_stock(stock_name)
    return {'value': round(stock.value / stock.market.exchange_rate, 2),
            'time': stock.market.time.strftime('%H:%M'),
            'key': str(stock_name.key()),
            'name': stock_name.name}


@route('/api/stockprice')
def api_stockprice():
    market_name, code = request.query.query.split(':')
    market_ref = [m[0] for m in MARKETS].index(market_name)
    stock_name = markets.util.get_stock_name(market_ref, code)
    return json.dumps(stockprice(stock_name))


@route('/api/stockhistory')
def api_stockhistory():
    market_name, code = request.query.query.split(':')
    stamp = getattr(request.query, 'stamp', False)
    if stamp:
        stamp_func = get_stamp
    else:
        stamp_func = lambda x: x.strftime('%Y-%m-%d')
    market_ref = [m[0] for m in MARKETS].index(market_name)
    stock_name = markets.util.get_stock_name(market_ref, code)
    stocks = markets.util.get_stocks_days(stock_name, 10)
    values = [[stamp_func(e[0]), e[1].value/e[2]] for e in stocks]

    return json.dumps({'series': {'label': code,
                                  'data': values},
                       'latest': stockprice(stock_name)
                       })


@route('/api/stockhistoryday')
def api_stockhistoryday():
    market_name, code = request.query.query.split(':')
    stamp = getattr(request.query, 'stamp', False)
    if stamp:
        stamp_func = get_stamp
    else:
        stamp_func = lambda x: x.strftime('%H:%M')
    date = getattr(request.query, 'date', None)
    if date:
        try:
            dt = datetime.datetime.strptime(date, '%Y-%m-%d')
        except:
            return "Invalid date format"
    else:
        dt = datetime.datetime.now()

    market_ref = [m[0] for m in MARKETS].index(market_name)
    stock_name = markets.util.get_stock_name(market_ref, code)
    stocks = markets.util.get_stocks_in_day(stock_name, dt)

    values = [[stamp_func(e[0]), e[1].value/e[2]] for e in stocks]

    return json.dumps({'series': {'label': code,
                                  'data': values},
                       'latest': stockprice(stock_name)
                       })


@route('/api/market/<ref>')
def api_get_market(ref):
    market = markets.util.get_market(int(ref))
    stocks = market.stocks
    return json.dumps([{'code': s.name.code, 'name': s.name.name, 'price': s.value, 'perc': s.diff} for s in stocks])


@route('/api/matches')
def api_get_matches():
    matches = game.models.Match.all().fetch(500)
    out = []
    for match in matches:
        dict_match = {}
        dict_match['user'] = str(match.user.nickname())
        dict_match['player'] = game.models.PLAYERS[match.player]
        dict_match['money'] = match.money_available
        dict_match['equity_mtm_before'] = match.mtm_before
        dict_match['equity_mtm'] = match.mtm_now
        dict_match['total_mtm'] = match.mtm_now + match.money_available
        dict_match['easy_mode'] = match.easy_mode
        dict_match['assets'] = {}
        for asset in match.assets:
            dict_match['assets'][asset.name.code] = asset.shares
        out.append(dict_match)
    return json.dumps(out)


@route('/api/num_shares')
def api_num_shares():
    match_key = request.query.match
    market_name, code = request.query.query.split(':')
    market_ref = [m[0] for m in MARKETS].index(market_name)
    stock_name = markets.util.get_stock_name(market_ref, code, keys_only=True)
    return str(getattr(game.util.get_asset(match_key, stock_name), 'shares', 0))
