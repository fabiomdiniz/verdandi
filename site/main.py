 # -*- coding: utf-8 -*-

from bottle import route, run, view, static_file, request, get, post, redirect
import bottle
import os.path
import json

from markets import MARKETS
import markets.util
import markets.models
import game.gameflow
import game.util
import game.models

SITE_ROOT = os.path.dirname(os.path.realpath(__file__))


@get('/')
@view('index')
def index():
    return dict()


@post('/')
def index_post():
    if game.util.valid_match(request.POST):
        game.gameflow.create_match(request.POST)
        redirect("/battle")
    return 'CODE ME'


@route('/reference')
@view('reference')
def reference():
    return dict()


@route('/battle')
@view('battle')
def battle():
    return dict()


@route('/matches')
def get_matches():
    matches = game.models.Match.all().fetch(500)
    out = ''
    for match in matches:
        out += '<br> User : '
        out += str(match.user.nickname())
        out += '<br> Player: '
        out += game.models.PLAYERS[match.player]
        out += '<br> Money: '
        out += str(match.money_available)
        out += '<br> MtM Before : '
        out += str(match.mtm_before)
        out += '<br> MtM : '
        out += str(match.mtm_now)
        out += '<br> Easy Mode : '
        out += str(match.easy_mode)
        out += '<br> Assets : '
        for asset in match.assets:
            out += '<br>'
            out += asset.name.code + ' - ' + str(asset.shares)
        out += '<br><br>'
    return out


@route('/market/<ref>')
def get_market(ref):
    market = markets.util.get_market(int(ref))

    stocks = market.stocks
    return '<br>'.join([' '.join(map(str, [s.name.code, s.name.name, s.value, s.diff])) for s in stocks])


@route('/cron/run_markets')
def run_markets():
    result = ['----FETCHERS----']
    for i, market in enumerate(MARKETS):
        try:
            market[1].get_market()
        except ValueError as e:
            result.append(' - '.join([str(i), market[0], repr(e)]))
        else:
            result.append(' - '.join([str(i), market[0], "OK"]))

    result += ['----MATCHES----']
    result += game.gameflow.update_matches()
    return '<br>'.join(result)


@route('/cron/fetch_market/<ref>')
def fetch_market(ref):
    #if datetime.datetime.today().isoweekday() not in (6, 7):
    if True:
        ref = int(ref)
        try:
            MARKETS[ref][1].get_market()
        except ValueError as e:
            return ' - '.join([MARKETS[ref][0], repr(e)])
        else:
            return ' - '.join([MARKETS[ref][0], "OK"])
    else:
        return 'WEEKEND!'


@route('/api/stockname')
def api_stockname():
    names = markets.models.StockName.all().filter('market_ref IN', map(int, request.query.markets.split(';'))).fetch(5000)
    return json.dumps([' - '.join([MARKETS[s.market_ref][0] + ':' + s.code, s.name]) for s in names])


@route('/api/stockprice')
def api_stockprice():
    market_name, code = request.query.query.split(':')
    market_ref = [m[0] for m in MARKETS].index(market_name)
    if market_ref == 0:
        correc = game.util.get_exchange()
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


@route('/clear_database')
def clear_database():
    from google.appengine.api import users

    if users.is_current_user_admin():
        markets.models.clear_db()
        game.models.clear_db()
        return 'OK'
    else:
        return 'NOPE'


@route('/clear_game_database')
def clear_game_database():
    from google.appengine.api import users

    if users.is_current_user_admin():
        game.models.clear_db()
        return 'OK'
    else:
        return 'NOPE'


@route('/static/img/<filename:re:.*\.png>#')
def send_image(filename):
    return static_file(filename, root=os.path.join(SITE_ROOT, 'static', 'img'), mimetype='image/png')


@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root=os.path.join(SITE_ROOT, 'static'))

bottle.debug(True)

run(server='gae', debug=True)
