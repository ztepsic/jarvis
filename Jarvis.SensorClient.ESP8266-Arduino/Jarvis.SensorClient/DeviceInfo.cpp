#include <ESP8266WiFi.h>

class DeviceInfo {
	
	public:
	  static String getSerial(){
		  //return String(ESP.getFlashChipId(), HEX);
      return String(ESP.getChipId(), HEX);
	  }

    static String getHost() {
      return WiFi.hostname();
    }
};
