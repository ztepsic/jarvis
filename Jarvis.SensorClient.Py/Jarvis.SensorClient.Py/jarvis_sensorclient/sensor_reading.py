class SensorReading(object):
    """Sensor reading class"""

    device_id = None
    device_ext_id = None
    host = None
    sensor_id = None
    sensor_serial_no = None
    location = None
    timestamp = None
    unix_timestamp = None
    value = None
    value_type_id = None
    value_type = None

    def __init__(self, **kwargs):
        return super(SensorReading, self).__init__(**kwargs)