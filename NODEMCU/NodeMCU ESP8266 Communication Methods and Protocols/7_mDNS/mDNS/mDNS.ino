#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
const char* wifiName = "PAL-HOME-XI";
const char* wifiPass = "palpalpal";
ESP8266WebServer server(80);
//Handles http request
void handleRoot() {
digitalWrite(2, 0); //Blinks on board led on page request
server.send(200, "text/plain", "hello from esp8266! mDNS demo");
digitalWrite(2, 1);
}
void setup() {
Serial.begin(115200);
delay(10);
Serial.println();
Serial.print("Connecting to ");
Serial.println(wifiName);
WiFi.begin(wifiName, wifiPass);
while (WiFi.status() != WL_CONNECTED) {
delay(500);
Serial.print(".");
}
Serial.println("");
Serial.println("Wi-Fi connected");
Serial.println("IP address: ");
Serial.println(WiFi.localIP()); //You can get IP address assigned to ESP
if(WiFi.status() == WL_CONNECTED) //If Wi-Fi connected then start mDNS
{
if (MDNS.begin("esp8266")) { //Start mDNS with name esp8266
Serial.println("MDNS started at esp8266.local");
}
}
server.on("/", handleRoot); //Associate handler function to path
server.begin(); //Start server
Serial.println("HTTP server started");
}
void loop() {
//Handle Clinet requests
server.handleClient();
}

