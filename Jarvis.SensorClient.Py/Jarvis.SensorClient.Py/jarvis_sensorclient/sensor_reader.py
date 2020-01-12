import Adafruit_DHT

class SensorReader(object):
    """Sensor reader"""

    @staticmethod
    def read(sensor_model, pin):
        values = {};
        if sensor_model in ("DHT11", "DHT22", "AM2302"):
            sensors = { 'DHT11': Adafruit_DHT.DHT11,
                'DHT22': Adafruit_DHT.DHT22,
                'AM2302': Adafruit_DHT.AM2302 }
            sensor = sensors[sensor_model]
            humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
            
            values["humidity"] = round(humidity, 2)
            values["temperature"] = round(temperature, 2)
            
        if sensor_model == "fake":
            values["humidity"] = 56
            values["temperature"] = 26.50

        return values;


