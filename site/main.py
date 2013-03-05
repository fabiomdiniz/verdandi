 # -*- coding: utf-8 -*-

from bottle import route, run, view, static_file, request, get, post, redirect
import os.path

import api.views
import markets.views
import game.views
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
    matches = game.util.get_matches()
    return {'mtm_now': round(matches[0].mtm_now, 2), 'mtm_before': round(matches[0].mtm_before, 2),
            'ai_mtm_now': round(matches[1].mtm_now, 2), 'ai_mtm_before': round(matches[1].mtm_before, 2),
            'ai_name': game.models.PLAYERS[matches[1].player],
            'assets': matches[0].assets}


@route('/clear_market_database')
def clear_database():
    from google.appengine.api import users

    if users.is_current_user_admin():
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


run(server='gae')
