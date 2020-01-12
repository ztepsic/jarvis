"""
The flask application package.
"""

import logging
from flask import Flask
app = Flask(__name__, instance_relative_config=True)
app.config.from_object('jarvis_svc.default_settings')
app.config.from_pyfile('app.cfg', silent = True)

logging.basicConfig(filename='jarvis.log', level=logging.WARNING)

import jarvis_svc.views
