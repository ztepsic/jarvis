#include "SensorService.h"
#include <ArduinoJson.h>
#include "Config.h"
#include "DeviceInfo.cpp"
#include "SensorReader.cpp"
#include <time.h>
#include <ESP8266HTTPClient.h>

const char* SensorService::toJsonString(std::vector<t_sensor_reading> sensorReadings) {
  //
  // Step 1: Reserve memory space
  //
  StaticJsonBuffer<500> jsonBuffer;
  
  //
  // Step 2: Build object tree in memory
  //
  JsonArray& sensorReadingsJsonArray = jsonBuffer.createArray();
  
  for(int i = 0; i < sensorReadings.size(); i++) {
    JsonObject& sensorReadingJson = jsonBuffer.createObject();
    sensorReadingJson["device_ext_id"] = sensorReadings[i].deviceExtId;
    sensorReadingJson["device_id"] = sensorReadings[i].deviceId;
    sensorReadingJson["host"] = sensorReadings[i].host;
    sensorReadingJson["sensor_id"] = sensorReadings[i].sensorId;
    sensorReadingJson["sensor_serial_no"] = sensorReadings[i].sensorSerialNo;
    sensorReadingJson["timestamp"] = sensorReadings[i].timestamp;
    sensorReadingJson["value"] = sensorReadings[i].value;
    sensorReadingJson["value_type"] = sensorReadings[i].valueType;
    sensorReadingJson["value_type_id"] = sensorReadings[i].valueTypeId;
    
    sensorReadingsJsonArray.add(sensorReadingJson);
  }
  
  char jsonString[500];
  sensorReadingsJsonArray.printTo(jsonString, sizeof(jsonString));
  
  return jsonString;
      
};


std::vector<t_sensor_reading> SensorService::prepareData() {
  std::vector<t_sensor_reading> sensor_readings;

  std::vector<t_sensor> sensors = Config::getSensors();
  
  for(int i = 0; i < sensors.size(); i++) {
    time_t now = time(nullptr);
    //const char* timestamp = ctime(&now);

    const struct tm* timeinfo = (struct tm *)localtime(&now);
    char timestamp[26];
    //2017-01-21T20:51:10:391778
    sprintf(timestamp, "%d-%02d-%02dT%02d:%02d:%02d",
      1900 + timeinfo->tm_year, 1 + timeinfo->tm_mon, timeinfo->tm_mday,
      timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
    
    
    // read sensor data
    std::vector<t_sensor_value> values = SensorReader::read(sensors[i].model, sensors[i].gpio_pin);
    
    // for returned values make reading values
    for(int j = 0; j < values.size(); j++){
      int valueTypeId = 0;
      for(int k = 0; k < sensors[i].capabilities.size(); k++){
        if(strcmp(sensors[i].capabilities[k].type, values[j].valueType) == 0) {
          valueTypeId = sensors[i].capabilities[k].id;
        }
      }
      sensor_readings.push_back({Config::getDeviceId(), DeviceInfo::getSerial(), DeviceInfo::getHost(), sensors[i].id, sensors[i].serial_no, timestamp, values[j].value, valueTypeId, values[j].valueType});
    }

  }

  return sensor_readings;
  
}

void SensorService::sendSensorReadings() {
  HTTPClient http;
  http.begin(Config::getServiceUrl());
  http.addHeader("Content-Type", "application/json");
  std::vector<t_sensor_reading> sr = SensorService::prepareData();
  const char* response = SensorService::toJsonString(sr);
  auto httpCode = http.POST(response);
  Serial.print(httpCode);
  Serial.print(": Sensor data sent to: ");
  Serial.println(Config::getServiceUrl());
  http.end();
}


