 # -*- coding: utf-8 -*-

from game.models import Match, PLAYERS
from datetime import datetime

import ai


def update_matches():
    results = []
    is_friday = datetime.today().weekday() == 4

    ai_coordinates = {ai_id : ai_module.think() for ai_id, ai_module in ai.AIS.items()}

    for i, match in enumerate(Match.all().run()):
        if match.player != 0:  # Not human
            if is_friday or (not match.easy_mode):  # Only update if on hardmode or if it is friday
                ai.AIS[match.player].update_match(match, ai_coordinates[match.player])
        match.refresh_mtm()
        results.append(' - '.join([str(i), match.user.nickname(), PLAYERS[match.player], "OK"]))

    return results
