#include "Config.h"
#include <ArduinoJson.h>
#include "FS.h"

int Config::deviceId;
const char* Config::wiFiSsid;
const char* Config::wiFiPass;
const char* Config::serviceUrl;
long Config::sendSensorReadingInterval;
int Config::timezone;
int Config::daylightOffset;
std::vector<const char*> Config::ntps;
std::vector<t_sensor> Config::sensors;

void Config::init() {
  File configFile = SPIFFS.open("/config.json", "r");
  if (!configFile) {
    Serial.println("Failed to open config file");
    return;
  }

  size_t size = configFile.size();
  Serial.print("Config file size: ");
  Serial.println(size);
  
  if (size > 1024) {
    Serial.println("Config file size is too large");
    return;
  }

  // Allocate a buffer to store contents of the file.
  std::unique_ptr<char[]> buf(new char[size]);

  // We don't use String here because ArduinoJson library requires the input
  // buffer to be mutable. If you don't use ArduinoJson, you may as well
  // use configFile.readString instead.
  configFile.readBytes(buf.get(), size);
  //Serial.println(configFile.readString());

  StaticJsonBuffer<500> jsonBuffer;
  JsonObject& json = jsonBuffer.parseObject(buf.get());

  if (!json.success()) {
    Serial.println("Failed to parse config file");
    return;
  }

  // must copy strings because if WiFiClient called after it fill free all pointers to strings
  wiFiSsid = strdup(json["wifi_ssid"]);
  wiFiPass = strdup(json["wifi_pass"]);
  serviceUrl = strdup(json["service_url"]);
  sendSensorReadingInterval = atol(json["send_sensor_reading_interval"]);
  timezone = atoi(json["timezone"]);
  daylightOffset = atoi(json["daylightOffset"]);
  deviceId = atoi(json["device_id"]);
  
  JsonArray& ntpsJson = json["ntps"].asArray();
  for (int i = 0; i < ntpsJson.size(); i++) {
    ntps.push_back(strdup(ntpsJson[i]));
  }
  
  JsonArray& sensorsJson = json["sensors"];
  for(JsonArray::iterator it=sensorsJson.begin(); it!=sensorsJson.end(); ++it) {
    // *it contains the JsonVariant which can be casted as usuals
    JsonObject& sensorJson = *it;

    JsonArray& capabilitiesJson = sensorJson["capabilities"];
    std::vector<t_sensor_capabilities> capabilities;
    for(JsonArray::iterator cap_it=capabilitiesJson.begin(); cap_it!=capabilitiesJson.end(); ++cap_it) {
      JsonObject& capabilityJson = *cap_it;
      capabilities.push_back({ atoi(capabilityJson["id"]), strdup(capabilityJson["type"]) });
    }

    sensors.push_back({atoi(sensorJson["id"]), strdup(sensorJson["serial_no"]), strdup(sensorJson["model"]), atoi(sensorJson["gpio_pin"]), capabilities});

  }

  configFile.close();

}

int Config::getDeviceId() { return deviceId; }
const char* Config::getWiFiSsid() { return wiFiSsid; }
const char* Config::getWiFiPass() { return wiFiPass; }
const char* Config::getServiceUrl() { return serviceUrl; }
long Config::getSendSensorReadingInterval() { return sendSensorReadingInterval; }
int Config::getTimezone() { return timezone; }
int Config::getDaylightOffset() { return daylightOffset; }
std::vector<const char*> Config::getNtps() { return ntps; }
std::vector<t_sensor> Config::getSensors() { return sensors; }


