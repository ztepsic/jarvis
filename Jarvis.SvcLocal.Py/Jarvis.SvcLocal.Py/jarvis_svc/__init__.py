"""
The flask application package.
"""

from flask import Flask
app = Flask(__name__)

app.config["data_target_destination"] = "CSV"

import jarvis_svc.views
