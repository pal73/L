#include <ESP8266WiFi.h>
//Static IP address configuration
IPAddress staticIP(192, 168, 2, 99); //ESP static ip
IPAddress gateway(192, 168, 2, 1); //IP Address of your Wi-Fi Router(Gateway)
IPAddress subnet(255, 255, 255, 0); //Subnet mask
IPAddress dns(8, 8, 8, 8); //DNS defaut
const char* deviceName = "pal_esp"; //used to identify in router
//On board LED Connected to GPIO2
#define LED 2
//SSID and Password of your Wi-Fi router
//const char* ssid = "PAL-HOME-XI";
//const char* password = "palpalpal";
const char* ssid = "SPA2016";
const char* password = "UMHHwAGa";
void setup(void){
Serial.begin(115200);
Serial.println("");
Serial.print("ESP8266 MAC: ");
Serial.println(WiFi.macAddress());
//Prevent connecting to Wi-Fi based on previous configuration
WiFi.disconnect();
// DHCP Hostname (useful for finding device for static lease)
WiFi.hostname(deviceName);
WiFi.config(staticIP, subnet, gateway, dns);
WiFi.begin(ssid, password);
WiFi.mode(WIFI_STA); //Wi-Fi mode station (connect to Wi-Fi router only
// Wait for connection
while (WiFi.status() != WL_CONNECTED) {
delay(500);
Serial.print(".");
}
//If connection successful show IP address in serial monitor
Serial.println("");
Serial.print("Connected to ");
Serial.println(ssid);
Serial.print("IP address: ");
Serial.println(WiFi.localIP()); //IP address assigned to your ESP

}
//============================================================
// LOOP
//============================================================
void loop(void){
//Nothing to do here
delay(1000);
}
