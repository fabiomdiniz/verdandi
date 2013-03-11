 # -*- coding: utf-8 -*-
import os
import random

import markets
import markets.util
from markets.models import Stock


def think():
    knowledge = {}
    for comb in markets.markets_comb:
        keys = [markets.util.get_market(ref).key() for ref in comb]
        # 5 top perc change
        stocks = Stock.all().filter("market IN", keys).order('-diff').fetch(5)
        knowledge[comb] = [s.name for s in stocks]
    return knowledge


def get_quote():
    return random.choice(open(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'verdandi_quotes')).readlines())
