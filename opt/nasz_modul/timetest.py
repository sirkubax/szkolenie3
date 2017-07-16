#!/usr/bin/python

import datetime
import json

date = str(datetime.datetime.now())
print json.dumps({
    "time" : date
})

#wykonaj
#ansible -m timetest.py  localhost --module-path=.
