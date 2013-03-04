 # -*- coding: utf-8 -*-

from bottle import route, request

import json

from markets import MARKETS
import markets.views
import markets.util
import markets.models
import game.gameflow
import game.util
import game.models


@route('/api/stockname')
def api_stockname():
    names = markets.models.StockName.all().filter('market_ref IN', map(int, request.query.markets.split(';'))).fetch(5000)
    return json.dumps([' - '.join([MARKETS[s.market_ref][0] + ':' + s.code, s.name]) for s in names])


@route('/api/stockprice')
def api_stockprice():
    market_name, code = request.query.query.split(':')
    market_ref = [m[0] for m in MARKETS].index(market_name)
    if market_ref == 0:
        correc = markets.util.get_exchange()
    else:
        correc = 1.0
    stock_name = markets.util.get_stock_name(market_ref, code)
    stock = markets.util.get_stock(stock_name)
    import logging
    logging.info(stock)
    return json.dumps({'value': round(stock.value / correc, 2),
                       'time': stock.market.datetime.strftime('%H:%M'),
                       'key': str(stock_name.key()),
                       'name': stock_name.name})


@route('/api/market/<ref>')
def api_get_market(ref):
    market = markets.util.get_market(int(ref))

    stocks = market.stocks
    return json.dumps([{'code': s.name.code, 'name': s.name.name, 'price': s.value, 'perc': s.diff} for s in stocks])


@route('/api/matches')
def ap_get_matches():
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
