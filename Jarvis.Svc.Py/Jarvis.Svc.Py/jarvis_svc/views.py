"""
Routes and views for the flask application.
"""

import sys
import os
import json
import requests
import threading

from datetime import datetime
from flask import render_template
from jarvis_svc import app
from flask.json import jsonify
from flask import request
from flask import Response
from jarvis_svc.sensor_reading import SensorReading
from jarvis_svc.csv_helper import CsvHelper

@app.context_processor
def utility_processor():
    def format_datetime(str_datetime):
        return datetime.strptime(str_datetime, '%Y-%m-%dT%H:%M:%S.%f').strftime("%Y-%m-%d %H:%M:%S")
    return dict(format_datetime=format_datetime)

@app.route('/')
@app.route('/home')
def home():
    """Renders the home page."""

    return render_template(
        'index.html',
        title='Jarvis'
    )

@app.route("/cur")
@app.route("/current")
def current_reading():
    """Renders current reading of local sensor and writes to CSV file"""

    output = os.popen(app.config["SENSOR_READ_CMD"],"r",1)
    json_data = output.read()
    sensor_readings_jdata = json.loads(json_data)
    if not isinstance(sensor_readings_jdata, list):
        sensor_readings_jdata = [sensor_readings_jdata]

    thread = threading.Thread(target=write_to_csv, args=(sensor_readings_jdata,))
    thread.deamon = True
    thread.start()

    return render_template(
        'sensor_reading.html',
        title='Jarvis',
        content=sensor_readings_jdata
    )

@app.route("/cur/json")
@app.route("/current/json")
def current_reading_json():
    """Renders current reading of local sensor and returns it in json form"""
    output = os.popen(app.config["SENSOR_READ_CMD"],"r",1)
    json_data = output.read()
    return json_data, 200, {'Content-Type': 'application/json'}

@app.route("/sensor-reading/add", methods = ["POST"])
def sensor_reading_add():
    """Adds sensor reading"""

    sensor_readings_jdata = request.get_json()
    if not isinstance(sensor_readings_jdata, list):
        sensor_readings_jdata = [sensor_readings_jdata]

    thread = threading.Thread(target=write_to_csv, args=(sensor_readings_jdata,))
    thread.deamon = True
    thread.start()
    
    return Response(None, status=200, mimetype='application/json')

def write_to_csv(sensor_readings_jdata):
    """Writes sensor readings JSON data to CSV file"""

    sensor_readings = []
    if set(("device_id", "device_ext_id", "host", "sensor_id", "sensor_serial_no", "location", "timestamp", "unix_timestamp", "value", "value_type_id", "value_type")).issubset(sensor_readings_jdata[0]):
        for sensor_reading_jdata in sensor_readings_jdata:
            sensor_reading = map_dict_values_to_sensor_reading(sensor_reading_jdata)
            #sensor_reading.ip_addr = request.remote_addr

            sensor_readings.append(sensor_reading)


    if sensor_readings:
        # Try to insert to database or send to another service
            # if insert to database or sending to another service is successful
                # read csv files and insert them to database or send to another service
                # move csv file to archive -> if same filename exists in arhcive append count + 1
        # if database or service not available generate csv file
        csv_filename = CsvHelper.generate_filename()
        filednames_header = ["device_id", "device_ext_id", "host", "sensor_id", "sensor_serial_no", "location", "timestamp", "unix_timestamp", "value", "value_type_id", "value_type"]

        data = []
        for sensor_reading in sensor_readings:
            send_to_influxdb_cloud(sensor_reading)
            data.append(sensor_reading.__dict__)

        CsvHelper.write_to_csv(csv_filename, filednames_header, data)

def map_dict_values_to_sensor_reading(sensor_reading_jdata):
    """Maps JSON sensor reading data to SensorReading class instance"""

    sensor_reading = SensorReading()
    sensor_reading.device_id = sensor_reading_jdata["device_id"]
    sensor_reading.device_ext_id = sensor_reading_jdata["device_ext_id"]
    sensor_reading.host = sensor_reading_jdata["host"]
    sensor_reading.sensor_id = sensor_reading_jdata["sensor_id"]
    sensor_reading.sensor_serial_no = sensor_reading_jdata["sensor_serial_no"]
    sensor_reading.location = sensor_reading_jdata["location"]
    sensor_reading.timestamp = sensor_reading_jdata["timestamp"]
    sensor_reading.unix_timestamp = sensor_reading_jdata["unix_timestamp"]
    sensor_reading.value = sensor_reading_jdata["value"]
    sensor_reading.value_type_id = sensor_reading_jdata["value_type_id"]
    sensor_reading.value_type = sensor_reading_jdata["value_type"]

    return sensor_reading

def send_to_influxdb_cloud(sensor_reading):
    """Sends sensor reading data to InfluxDB Cloud"""

    token = app.config["INFLUXDB_TOKEN"];
    organization = app.config["INFLUXDB_ORGANIZATION"];
    bucket = app.config["INFLUXDB_BUCKET"];

    headers = { "content-type": "text/plain", "Authorization": "Token {token}".format(token=token) }

    field_value = ("temp=" if sensor_reading.value_type == "temperature" else "hum=") + str(sensor_reading.value)

    request_data = "{value_type},device_id={device_id},host={host},sensor_id={sensor_id},sensor_serial={sensor_serial},location={location} {field_value} {unix_timestamp}" \
        .format(value_type = sensor_reading.value_type,
                device_id = sensor_reading.device_id,
                host = sensor_reading.host,
                sensor_id = sensor_reading.sensor_id,
                sensor_serial = sensor_reading.sensor_serial_no,
                location = sensor_reading.location.replace(" ", "\ ").replace("=", "\=").replace(",", "\,"),
                field_value = field_value,
                unix_timestamp = sensor_reading.unix_timestamp)
    response = requests.post("https://eu-central-1-1.aws.cloud2.influxdata.com/api/v2/write?org={0}&bucket={1}&precision=s".format(organization, bucket), data = request_data, headers = headers)
