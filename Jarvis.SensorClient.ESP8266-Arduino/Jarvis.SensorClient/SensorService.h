#ifndef _SENSOR_SERVICE_H
#define _SENSOR_SERVICE_H

#include <vector>
#include "SensorReading.h"

class SensorService {
    public:
      static const char* toJsonString(std::vector<t_sensor_reading> sensorReadings);
      static std::vector<t_sensor_reading> prepareData();
      static void sendSensorReadings();
  
};

#endif;

