# Jarvis
Home automation system

## Raspberry Pi

### Jarvis.SensorClient

**Jarvis.SensorClient** is console app that reads data from attached sensors on Raspberry Pi.

#### Configuration file
In root of application folder (e.g Jarvis.SensorClient) there is `config.json` file.


#### Commands

To get current sensor readings use this command:

    python run_sensorclient.py cur
    
Values will be displayed in standard output as:

    > temperature = 21
    > humidity = 45

    
To get current sensor readings in JSON format use this command:  

    python run_sensorclient.py cur json
    
Values will be displayed in standard output in JSON format as:

```json
[
    {
        "device_ext_id": "device",
        "device_id": 1,
        "host": "host",
        "location": "living room",
        "sensor_id": 2,
        "sensor_serial_no": "SERIAL_NO",
        "timestamp": "2020-01-12T11:30:56.498990",
        "unix_timestamp": 1578825056,
        "value": 21.6,
        "value_type": "temperature",
        "value_type_id": 1
    },
    {
        "device_ext_id": "device",
        "device_id": 1,
        "host": "host",
        "location": "living room",
        "sensor_id": 2,
        "sensor_serial_no": "SERIAL_NO",
        "timestamp": "2020-01-12T11:30:56.498990",
        "unix_timestamp": 1578825056,
        "value": 45,
        "value_type": "humidity",
        "value_type_id": 2
    }
]
```

To get current sensor readings and send it to Jarvis.Svc web service use this command:

    python run_sensorclient.py

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

#### Configuration file
`config.json` file is used to define configuration.
