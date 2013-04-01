 # -*- coding: utf-8 -*-
from google.appengine.ext import db
from google.appengine.api.users import get_current_user
from google.appengine.api import users

from bottle import route, request, abort, response

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
            'date': stock.market.date.strftime('%Y-%m-%d'),
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

    market_ref = [m[0] for m in MARKETS].index(market_name)
    stock_name = markets.util.get_stock_name(market_ref, code)

    date = getattr(request.query, 'date', None)
    if date:
        try:
            dt = datetime.datetime.strptime(date, '%Y-%m-%d').date()
        except:
            return "Invalid date format"
    else:
        #dt = datetime.datetime.now()
        dt = markets.util.get_last_date(market_ref)

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
        dict_match['mtm_before'] = match.mtm_before
        dict_match['mtm_now'] = match.mtm_now
        dict_match['easy_mode'] = match.easy_mode
        dict_match['assets'] = {}
        for asset in match.assets:
            dict_match['assets'][asset.name.code] = asset.shares
        out.append(dict_match)
    return json.dumps(out)


@route('/api/match_history')
def api_get_match_history():
    matches = game.util.get_matches()
    human_matches = game.models.MatchHistory.all().filter("match =", matches[0].key()).order('datetime').fetch(500)
    ai_matches = game.models.MatchHistory.all().filter("match =", matches[1].key()).order('datetime').fetch(500)

    stamp = getattr(request.query, 'stamp', False)
    if stamp:
        stamp_func = get_stamp
    else:
        stamp_func = lambda x: x.strftime("%m-%d %H:%M")

    human_values, ai_values = [[(stamp_func(e.datetime), e.mtm) for e in m_history]
                               for m_history in (human_matches, ai_matches)]

    return json.dumps([{'label': 'You', 'data': human_values}, {'label': game.models.PLAYERS[matches[1].player], 'data': ai_values}])


@route('/api/matches_history')
def api_get_matches_history():
    matches = game.models.MatchHistory.all().order('datetime').fetch(500)
    out = []
    for match in matches:
        dict_match = {}
        dict_match['user'] = str(match.match.user.nickname())
        dict_match['player'] = game.models.PLAYERS[match.match.player]
        dict_match['money'] = match.money
        dict_match['mtm'] = match.mtm
        dict_match['assets'] = {}
        for asset in match.assets:
            dict_match['assets'][asset.stock.name.code] = [asset.shares, asset.stock.value]
        out.append(dict_match)
    return json.dumps(out)


@route('/api/num_shares')
def api_num_shares():
    match_key = request.query.match
    market_name, code = request.query.query.split(':')
    market_ref = [m[0] for m in MARKETS].index(market_name)
    stock_name = markets.util.get_stock_name(market_ref, code, keys_only=True)
    return str(getattr(game.util.get_asset(match_key, stock_name), 'shares', 0))


@route('/api/buy_sell')
def api_buy_sell():
    match_key = request.query.match
    stock_name = request.query.stock_name
    shares = int(request.query.num_shares)
    match = db.Model.get(match_key)
    if get_current_user() == match.user:
        match.buy_sell_asset_keys([stock_name], [shares])
        return json.dumps('OK')
    else:
        abort(401, "NOPE")


@route('/api/total_dump')
def total_dump():
    if not users.is_current_user_admin():
        abort(401, "NOPE")
    values = []
    for ref in range(len(MARKETS)):
        values.append([ref])
        latest_market = markets.util.get_market(ref)
        stock_names = [s.name for s in markets.models.Stock.all().filter("market =", latest_market.key()).fetch(1000)]
        stock_names.sort(key=lambda x: x.code)
        values.append(['###DATE###'] + [s.code for s in stock_names])
        for market in markets.models.Market.all().filter("ref =", ref).order('-date').order('-time').fetch(1000):
            row = [market.get_datetime().strftime("%Y-%m-%d %H:%M")]
            row += [getattr(markets.models.Stock.all().filter("market =", market.key()).filter('name =', name.key()).get(), 'value', 0.0) for name in stock_names]
            values.append(row[:])

    values = [';'.join(map(str, row)) for row in values]
    response.set_header('Content-Disposition', 'attachment;filename=total_dump.csv')
    response.content_type = 'text/csv'
    return '\n'.join(values)
