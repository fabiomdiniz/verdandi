 # -*- coding: utf-8 -*-

from bottle import route

import datetime

from markets import MARKETS
import game.gameflow
import game.util
import game.models


@route('/cron/fetch_market/<ref>')
def fetch_market(ref):
    if datetime.datetime.today().isoweekday() not in (6, 7):
        ref = int(ref)
        try:
            MARKETS[ref][1].get_market()
            game.gameflow.update_matches()
        except ValueError as e:
            return ' - '.join([MARKETS[ref][0], repr(e)])
        else:
            return ' - '.join([MARKETS[ref][0], "OK"])
    else:
        return 'WEEKEND!'
