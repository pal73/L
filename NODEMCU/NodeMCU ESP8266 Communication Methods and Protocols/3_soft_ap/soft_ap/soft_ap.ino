#include <ESP8266WiFi.h>
//Enter SSID and Password for ESP8266
const char* ssid = "pal_esp";
const char* password = "palpal";
void setup()
{
Serial.begin(115200);
Serial.println();
Serial.print("Setting soft-AP ... ");
WiFi.softAP(ssid, password);
Serial.print("Access Point: ");
Serial.print(ssid);
Serial.println(" Started");
}
void loop()
{
int dev = WiFi.softAPgetStationNum();
Serial.printf("Devices connected = %d\n", dev);
delay(3000);
}
