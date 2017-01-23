#include "DHT.h"
#include <vector>

struct t_sensor_value {
    float value;
    const char* valueType;
};

const char HTTP[] PROGMEM = "http:";

class SensorReader {

  public:
    static std::vector<t_sensor_value> read(const char* sensorModel, int pin) {
      std::vector<t_sensor_value> sensor_values;
      
      int dhtType;
      if (strcmp(sensorModel, "DHT22") == 0) {
        dhtType = DHT22;
      } else if (strcmp(sensorModel, "DHT11") == 0) {
        dhtType = DHT11;
      } else if (strcmp(sensorModel, "DHT21") == 0) {
        dhtType = DHT21;
      }
      
      DHT dht(pin, dhtType);

      delay(2000);
      
      // Reading temperature or humidity takes about 250 milliseconds!
      // Read temperature as Celsius (the default)
      float temperature = dht.readTemperature();
      sensor_values.push_back({ temperature, "temperature" });
      
      // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
      float humidity = dht.readHumidity();
      sensor_values.push_back({ humidity, "humidity" });
    
      return sensor_values;
    
  }
 
};

