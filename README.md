# Jarvis
Home automation system

## Raspberry Pi

### Jarvis.SensorClient

**Jarvis.SensorClient** is console app that reads data from attached sensors on Raspberry Pi.

---

### Jarvis.Svc
**Jarvis.Svc** is web service on Raspberry Pi that accepts sensor readings.

#### Configuration file
In root of application folder (e.g Jarvis.Svc) create `instance` folder and in that folder create file `app.cfg` with the following structure:

    SENSOR_READ_CMD = "python /home/pi/jarvis/Jarvis.SensorClient/run_sensorclient.py cur json"
    INFLUXDB_TOKEN = "value"
    INFLUXDB_ORGANIZATION = "value"
    INFLUXDB_BUCKET = "value"

Application is started with:

    python runserver.py

---

## ESP8266 Arduino
### Jarvis.SensorClient

**Jarvis.SensorClient** is console app that reads data from attached sensors on ESO8266 Arduino
