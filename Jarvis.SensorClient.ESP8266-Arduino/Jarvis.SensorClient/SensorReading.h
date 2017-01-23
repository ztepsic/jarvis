#include <WString.h>

struct t_sensor_reading {
    int deviceId;
    String deviceExtId;
    String host;
    int sensorId;
    String sensorSerialNo;
    String timestamp;
    float value;
    int valueTypeId;
    String valueType;  
};

