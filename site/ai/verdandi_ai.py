 # -*- coding: utf-8 -*-
import os
import random


def update_match(match, coordinates):
    pass


def think():
    return {}


def get_quote():
    return random.choice(open(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'verdandi_quotes')).readlines())
