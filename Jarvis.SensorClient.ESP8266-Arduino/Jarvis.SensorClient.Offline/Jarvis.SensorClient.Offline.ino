#include <ESP8266WiFi.h>
#include <random>

#include "DHT.h"

#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// DHT constants
#define DHTPIN 2     // Digital pin connected to the DHT sensor
#define DHTTYPE DHT22   // DHT 22  (AM2302), AM2321

// Initialize DHT sensor.
DHT dht(DHTPIN, DHTTYPE);

// OLED Display constants
#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels

// Declaration for SSD1306 display connected using software SPI (default case):
#define OLED_CLK   14           // - D0 pin OLED display    // D5   14
#define OLED_MOSI   12          // - D1 pin OLED display    // D6   12
#define OLED_RESET 13           // - RST pin OLED display   // D7   13
#define OLED_DC    15           // - DC pin OLED            // D8   15
#define OLED_CS    5            // - CS pin OLED display    // D1   05

// Initialize SSD1306 OLED display
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT,
  OLED_MOSI, OLED_CLK, OLED_DC, OLED_RESET, OLED_CS);

#define LOGO_HEIGHT   16
#define LOGO_WIDTH    16
static const unsigned char PROGMEM logo_bmp[] =
{ B00000000, B11000000,
  B00000001, B11000000,
  B00000001, B11000000,
  B00000011, B11100000,
  B11110011, B11100000,
  B11111110, B11111000,
  B01111110, B11111111,
  B00110011, B10011111,
  B00011111, B11111100,
  B00001101, B01110000,
  B00011011, B10100000,
  B00111111, B11100000,
  B00111111, B11110000,
  B01111100, B11110000,
  B01110000, B01110000,
  B00000000, B00110000 };

std::random_device seeder;
std::mt19937 rng(seeder());
std::uniform_int_distribution<int> genXPos(0, 12); // uniform, unbiased
std::uniform_int_distribution<int> genYPos(0, 16); // uniform, unbiased

void setup() {
  Serial.begin(9600);
  Serial.println(F("DHTxx test!"));

  Serial.println(F("Turning WiFi Off"));
  //Turn off WiFi
  WiFi.mode(WIFI_OFF);

  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  if(!display.begin(SSD1306_SWITCHCAPVCC)) {
    Serial.println(F("SSD1306 allocation failed"));
    for(;;); // Don't proceed, loop forever
  }


  // Show initial display buffer contents on the screen --
  // the library initializes this with an Adafruit splash screen.
  display.display();
  delay(2000); // Pause for 2 seconds

  // Clear the buffer
  display.clearDisplay();

  dht.begin();

  // text display tests
  display.dim(true); // Dim the display.
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(0,0);
  display.println("DHT started");

  display.display();
  delay(2000);
  display.clearDisplay();
  
}

void loop() {
  // Wait a few seconds between measurements.
  delay(2000);

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  
  // Read temperature as Fahrenheit (isFahrenheit = true)
  //float f = dht.readTemperature(true);

  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  // Compute heat index in Fahrenheit (the default)
  //float hif = dht.computeHeatIndex(f, h);
  // Compute heat index in Celsius (isFahreheit = false)
  //float hic = dht.computeHeatIndex(t, h, false);

  Serial.print(F("Temperature: "));
  Serial.print(t);
  Serial.print(F(" °C\t"));

  Serial.print(F("Humidity: "));
  Serial.print(h);
  Serial.print(F(" %"));

  // generate random coordinates for display to prevend OLED burn in
  int xPos = genXPos(rng);
  int yPos = genYPos(rng);

  Serial.print(F("\t x,y:"));
  Serial.print(xPos);
  Serial.print(F(","));
  Serial.println(yPos);
  
  Serial.println();

  //display.invertDisplay(true);
  display.setTextColor(WHITE);
  display.setCursor(xPos,yPos); // default 0,0 or 12,16
  
  display.setTextSize(1.8);
  display.print("T: ");
  display.setTextSize(2);
  display.print(t);
  display.setTextSize(1.8);
  display.print(" o");
  display.setTextSize(2);
  display.println("C");

  display.println();
  
  display.setCursor(xPos,32+yPos); // 12,48
  display.setTextSize(1.8);
  display.print("H: ");
  display.setTextSize(2);
  display.print(h);
  display.print(" %");

  display.display();
  delay(2000);
  display.clearDisplay(); 
  
}
