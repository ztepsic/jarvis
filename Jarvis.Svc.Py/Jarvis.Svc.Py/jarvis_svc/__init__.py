"""
The flask application package.
"""

from flask import Flask
app = Flask(__name__, instance_relative_config=True)
app.config.from_object('jarvis_svc.default_settings')
app.config.from_pyfile('app.cfg', silent = True)

import jarvis_svc.views
