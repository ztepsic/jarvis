#ifndef _CONFIG_H
#define _CONFiG_H

#include <vector>
#include <ArduinoJson.h>

struct t_sensor_capabilities {
  int id;
  const char* type;
};

struct t_sensor {
  int id;
  const char* serial_no;
  const char* model;
  int gpio_pin;
  std::vector<t_sensor_capabilities> capabilities;
};

class Config {
  private:
    static const char* wiFiSsid;
    static const char* wiFiPass;
    static const char* serviceUrl;
    static long sendSensorReadingInterval;
    static int timezone;
    static int daylightOffset;
    static int deviceId;
    static std::vector<const char*> ntps;
    static std::vector<t_sensor> sensors;
    
  public:
    static void init();
    static int getDeviceId();
    static const char* getWiFiSsid();
    static const char* getWiFiPass();
    static const char* getServiceUrl();
    static long getSendSensorReadingInterval();
    static int getTimezone();
    static int getDaylightOffset();
    static std::vector<const char*> getNtps();
    static std::vector<t_sensor> getSensors();
    
};

#endif;
