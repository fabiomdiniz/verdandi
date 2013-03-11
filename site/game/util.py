 # -*- coding: utf-8 -*-
import math

from google.appengine.api.users import get_current_user
from google.appengine.ext import db

from game.models import Match, Asset
import markets.util


def valid_match(data):
    return True


def get_matches(user=None):
    if user is None:
        user = get_current_user()
    return Match.all().filter('user =', user).order('player').fetch(10)


def get_asset(match_key, stock_name_key):
    return Asset.all().filter('match =', db.Model.get(match_key).key()).filter('name =', db.Model.get(stock_name_key).key()).get()


def update_match(match, knowledge):
    import logging
    logging.error(match.money_available)
    match.sell_everything()
    logging.error(match.money_available)
    comb = tuple(map(int, match.market_refs.split(';')))
    value_per_share = match.money_available/len(knowledge[comb])
    for stock_name in knowledge[comb]:
        stock = markets.util.get_stock(stock_name)
        num_shares = math.floor(value_per_share/(stock.value/stock.market.exchange_rate))
        logging.error(str(markets.util.get_stock(stock_name).value) + ' - ' + str(num_shares))
        match.buy_sell_asset(stock_name, int(num_shares))
        logging.error(match.money_available)
