 # -*- coding: utf-8 -*-

from google.appengine.api.users import get_current_user
from google.appengine.ext import db

from game.models import Match, Asset


def valid_match(data):
    return True


def get_matches(user=None):
    if user is None:
        user = get_current_user()
    return Match.all().filter('user =', user).order('player').fetch(10)


def get_asset(match_key, stock_name_key):
    return Asset.all().filter('match =', db.Model.get(match_key).key()).filter('name =', db.Model.get(stock_name_key).key()).get()
