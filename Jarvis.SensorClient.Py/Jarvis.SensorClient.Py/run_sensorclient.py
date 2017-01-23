#!/usr/bin/python

import json
import sys
import os
import copy
import socket
import datetime
import requests
from jarvis_sensorclient.device_info import DeviceInfo
from jarvis_sensorclient.sensor_reading import SensorReading
from jarvis_sensorclient.sensor_reader import SensorReader

TIMESTAMP_FORMAT = "{:%Y-%m-%dT%H:%M:%S.%f}"
HEADERS = { "content-type": "application/json" }

base_path = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
with open(os.path.join(base_path, "config.json")) as config_file:
    config = json.load(config_file)


sensor_reading_base = SensorReading()
sensor_reading_base.device_id = config["device_id"]
sensor_reading_base.device_ext_id = DeviceInfo.get_serial()
sensor_reading_base.host = socket.gethostname()

readings = []
for sensor in config["sensors"]:
    reading_timestamp = TIMESTAMP_FORMAT.format(datetime.datetime.now())

    values = SensorReader.read(sensor["model"], sensor["gpio_pin"])
    for value_type, value in values.items():
        sensor_reading = copy.deepcopy(sensor_reading_base)
        sensor_reading.sensor_id = sensor["id"]
        sensor_reading.sensor_serial_no = sensor["serial_no"]
        sensor_reading.timestamp = reading_timestamp
        sensor_reading.value = value
        sensor_reading.value_type = value_type
        sensor_reading.value_type_id = next((item for item in sensor["capabilities"] if item["type"] == value_type),  None)["id"]

        readings.append(sensor_reading.__dict__)

current_args = ["current", "cur"];
if len(sys.argv) >= 2 and sys.argv[1] in current_args:
    if(len(sys.argv) >= 3 and sys.argv[2] == "json"):
        json_data = json.dumps(readings, sort_keys = True)
        #json_data = json.dumps(readings, sort_keys = True, indent=4, separators=(',', ': ')) # pretty print
        print(json_data)
    else:
        for reading in readings:
            print('{0} = {1:0.1f}'.format(reading["value_type"], reading["value"]))

else:
    request_data = json.dumps(readings, sort_keys = True)
    print(request_data)
    response = requests.post(config["service_url"], data = request_data, headers = HEADERS)
    print(response)

