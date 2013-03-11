 # -*- coding: utf-8 -*-

from game.models import Match, PLAYERS
from game.util import update_match
from markets.util import get_exchange
from datetime import datetime

import ai

from collections import defaultdict


def update_matches(ref):
    results = []
    is_friday = datetime.today().weekday() == 4

    ai_coordinates = {ai_id : ai_module.think() for ai_id, ai_module in ai.AIS.items()}

    for i, match in enumerate(Match.all().run()):
        if str(ref) in match.market_refs.split(';'):
            match.refresh_mtm()
            if match.player != 0:  # Not human
                if is_friday or (not match.easy_mode):  # Only update if on hardmode or if it is friday
                    update_match(match, ai_coordinates[match.player])
            results.append(' - '.join([str(i), match.user.nickname(), PLAYERS[match.player], "OK"]))

    return results


def create_match(data):
    if not data['ai']:
        ai_ref = 1
    else:
        ai_ref = int(data['ai']) + 1
    stock_keys = data['stock_keys'].split(';')
    stock_quantities = data['stock_quantities'].split(';')
    difficulty = data['difficulty']
    markets_refs = data['markets']
    match = Match(easy_mode=bool(difficulty == '1'),
                  market_refs=markets_refs)
    ai_match = Match(easy_mode=bool(difficulty == '1'),
                     market_refs=markets_refs,
                     player=int(ai_ref))
    match.put()
    ai_match.put()
    stock_group = defaultdict(int)
    for key, quantity in zip(stock_keys, stock_quantities):
        stock_group[key] += int(quantity)
    items = stock_group.items()
    keys = [e[0] for e in items]
    quantities = [e[1] for e in items]
    match.buy_sell_asset_keys(keys, quantities)
    ai_match.buy_sell_asset_keys(keys, quantities)
    match.refresh_mtm()
    ai_match.refresh_mtm()
    update_match(ai_match, ai.AIS[ai_match.player].think())
