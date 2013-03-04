 # -*- coding: utf-8 -*-

from google.appengine.api.users import get_current_user

from game.models import Match


def valid_match(data):
    return True


def get_matches(user=None):
    if user is None:
        user = get_current_user()
    return Match.all().filter('user =', user).order('player').fetch(10)
