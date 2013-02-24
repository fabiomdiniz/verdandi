 # -*- coding: utf-8 -*-
import time
from subprocess import call

while True:
    print 'touching'
    call(["touch", "main.py"])
    print 'sleeping'
    time.sleep(2)
