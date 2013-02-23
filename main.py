 # -*- coding: utf-8 -*-

from bottle import route, run, view, static_file
import os.path

from markets import MARKETS
import markets.util
import game.gameflow

SITE_ROOT = os.path.dirname(os.path.realpath(__file__))


@route('/')
@view('index')
def index():
    return dict()


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


@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root=os.path.join(SITE_ROOT, 'static'))

run(server='gae')
