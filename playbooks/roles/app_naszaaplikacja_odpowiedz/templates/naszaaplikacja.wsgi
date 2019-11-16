#!/usr/bin/python

activate_this = '{{ katalog_aplikacji }}/venv/bin/activate_this.py'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

import sys
sys.path.insert(0,"{{ katalog_aplikacji }}")
from aplikacja import app as application
