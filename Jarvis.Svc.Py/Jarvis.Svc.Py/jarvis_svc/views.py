"""
Routes and views for the flask application.
"""

from datetime import datetime
from flask import render_template
from jarvis_svc import app
from flask.json import jsonify
from flask import request
from flask import Response
from jarvis_svc.sensor_reading import SensorReading
from jarvis_svc.csv_helper import CsvHelper


@app.route('/')
@app.route('/home')
def home():
    """Renders the home page."""

    return render_template(
        'index.html',
        title='Home Page',
        year=datetime.now().year,
    )

@app.route("/sensor-reading/add", methods = ["POST"])
def sensor_reading_add():
    """Adds sensor reading"""

    sensor_readings_jdata = request.get_json()
    if not isinstance(sensor_readings_jdata, list):
        sensor_readings_jdata = [sensor_readings_jdata]

    if set(("device_id", "device_ext_id", "host", "sensor_id", "sensor_serial_no", "timestamp", "value", "value_type_id", "value_type")).issubset(sensor_readings_jdata[0]):
        sensor_readings = []
        for sensor_reading_jdata in sensor_readings_jdata:
            sensor_reading = SensorReading()
            sensor_reading.device_id = sensor_reading_jdata["device_id"]
            sensor_reading.device_ext_id = sensor_reading_jdata["device_ext_id"]
            sensor_reading.host = sensor_reading_jdata["host"]
            sensor_reading.sensor_id = sensor_reading_jdata["sensor_id"]
            sensor_reading.sensor_serial_no = sensor_reading_jdata["sensor_serial_no"]
            sensor_reading.timestamp = sensor_reading_jdata["timestamp"]
            sensor_reading.value = sensor_reading_jdata["value"]
            sensor_reading.value_type_id = sensor_reading_jdata["value_type_id"]
            sensor_reading.value_type = sensor_reading_jdata["value_type"]
            #sensor_reading.ip_addr = request.remote_addr

            sensor_readings.append(sensor_reading)


    if sensor_readings:


        # Try to insert to database or send to another service
            # if insert to database or sending to another service is successful
                # read csv files and insert them to database or send to another service
                # move csv file to archive -> if same filename exists in arhcive append count + 1
        # if database or service not available generate csv file
        csv_filename = CsvHelper.generate_filename()
        filednames_header = ["device_id", "device_ext_id", "host", "sensor_id", "sensor_serial_no", "timestamp", "value", "value_type_id", "value_type"]

        data = []
        for sensor_reading in sensor_readings:
            data.append(sensor_reading.__dict__)

        CsvHelper.write_to_csv(csv_filename, filednames_header, data)
        
    
    return Response(None, status=200, mimetype='application/json')

