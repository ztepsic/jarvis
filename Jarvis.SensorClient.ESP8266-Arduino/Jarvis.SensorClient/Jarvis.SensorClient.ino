#include <ArduinoJson.h>
#include "FS.h"

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <stdlib.h>

#include "Config.h"
#include "DeviceInfo.cpp"
#include "SensorService.h"

unsigned long previousMillis = 0;

ESP8266WebServer server(80);


void handleRoot() {
  std::vector<t_sensor_reading> sr = SensorService::prepareData();

  String response = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"/><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>" + DeviceInfo::getHost() + "</title></head><body><dl>";

  for(int i = 0; i < sr.size(); i++) {
    response += "<dt>Timestamp</dt>";
    response += "<dd>" + sr[i].timestamp +  "</dd>";
    response += "<dt>" + sr[i].valueType + "</dt>";
    response += "<dd>" + String(sr[i].value) +  "</dd>";  
  }

  response += "</dl></body></html>";
  
  server.send(200, "text/html",  response);
}

void handleJson() {
  std::vector<t_sensor_reading> sr = SensorService::prepareData();
  const char* response = SensorService::toJsonString(sr);
  
  server.send(200, "application/json",  response);
}

void handleNotFound() {
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET)?"GET":"POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i=0; i<server.args(); i++){
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }
  server.send(404, "text/plain", message);
}


void setup() {
  Serial.begin(9600);
  while(!Serial) { 
    // wait serial port initialization
  }

  Serial.println("Mounting FS...");
  if (!SPIFFS.begin()) {
    Serial.println("Failed to mount file system");
    return;
  }

  Config::init();

  SPIFFS.end();


  WiFi.begin(Config::getWiFiSsid(), Config::getWiFiPass());
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(Config::getWiFiSsid());
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  std::vector<const char*> ntps = Config::getNtps();
  switch(ntps.size()){
    case 1:
      configTime(Config::getTimezone() * 3600, Config::getDaylightOffset() * 3600, ntps[0]);
      break;
    case 2:
      configTime(Config::getTimezone() * 3600, Config::getDaylightOffset() * 3600, ntps[0], ntps[1]);
      break;
    case 3:
      configTime(Config::getTimezone() * 3600, Config::getDaylightOffset() * 3600, ntps[0], ntps[1], ntps[2]);
      break;
  }
  


  server.on("/", handleRoot);
  server.on("/json", handleJson);

//  server.on("/inline", [](){
//    server.send(200, "text/plain", "this works as well");
//  });

  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");

  delay(1000);
  
}

void loop() {
  server.handleClient();

  unsigned long currentMillis = millis();
 
  if(currentMillis - previousMillis >= Config::getSendSensorReadingInterval()) {
    previousMillis = currentMillis;   
    SensorService::sendSensorReadings();
  }
  
}


