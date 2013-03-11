 # -*- coding: utf-8 -*-

import brazil
import nasdaq
import dowjones

import itertools

MARKETS = (
    ('Ibovespa', brazil),
    ('Nasdaq-100', nasdaq),
    ('Dow Jones Composite', dowjones),
)


markets_comb = reduce(lambda x, y: x + y,
                      [list(itertools.combinations(range(len(MARKETS)), i+1))
                       for i in range(len(MARKETS))])
