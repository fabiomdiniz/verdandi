 # -*- coding: utf-8 -*-

from bottle import route, run, view, static_file, request, get, post, redirect

from google.appengine.api import users

import os.path

import ai
import api.views
import markets
import markets.views
import markets.models
import game.views
import game.gameflow
import game.util
import game.models

SITE_ROOT = os.path.dirname(os.path.realpath(__file__))


@get('/')
@view('index')
def index():
    matches = game.util.get_matches()
    if len(matches):
        redirect('/battle')
    else:
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


#@route('/convert')
#def convert():
#    for market in markets.models.Market.all().fetch(1000):
#        market.put()
#        #if market.ref is None:
#        #    market.ref = 0
#        #if market.exchange_rate is None:
#        #    if market.ref == 0:
#        #        market.exchange_rate = 1.9
#        #    else:
#        #        market.exchange_rate = 1.0
#        #if market.date is None:
#        #    market.date = market.datetime.date()
#        #if market.time is None:
#        #    market.time = market.datetime.time()
#        #market.put()
#    return 'OK'


@route('/battle')
@view('battle')
def battle():
    matches = game.util.get_matches()
    if not len(matches):
        redirect('/')
    if matches[0].mtm_now <= matches[1].mtm_now:
        quote = ai.AIS[matches[1].player].get_quote()
    else:
        quote = ''

    return {'mtm_now': round(matches[0].mtm_now, 2), 'mtm_before': round(matches[0].mtm_before, 2),
            'ai_mtm_now': round(matches[1].mtm_now, 2), 'ai_mtm_before': round(matches[1].mtm_before, 2),
            'ai_name': game.models.PLAYERS[matches[1].player],
            'active_markets': matches[0].market_refs,
            'money_available': round(matches[0].money_available, 2),
            'ai_match_key': matches[1].key(),
            'match_key': matches[0].key(),
            'perc': matches[0].get_perc(), 'ai_perc': matches[1].get_perc(),
            'quote': quote,
            'logout_url': users.create_logout_url("/")}


@route('/portfolio')
@view('portfolio')
def portfolio():
    matches = game.util.get_matches()
    return {'assets': matches[0].assets, 'MARKETS': markets.MARKETS}


@route('/surrender')
def surrender():
    matches = game.util.get_matches()
    map(lambda x: x.delete(), matches)
    redirect("/")


@route('/clear_market_database')
def clear_database():
    from google.appengine.api import users

    if users.is_current_user_admin():
        markets.models.clear_db()
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


run(server='gae')
