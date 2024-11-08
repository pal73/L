#define LED 8

#define USE_CLIENTSSL true  

#include <AsyncTelegram2.h>

const char *ssid[]     = {"Promautomatics_systems", "PAL-HOME-XI", "PAL-HOME-XI_EXT", "systems_promautomatic"};
const char *password[] = {"kk11146452", "palpalpal", "palpalpal", "bCGz37vn"};

  #include <WiFi.h>
  #include <WiFiClient.h>
  #if USE_CLIENTSSL
    #include <SSLClient.h>  
    #include "tg_certificate.h"
    WiFiClient base_client;
    SSLClient client(base_client, TAs, (size_t)TAs_NUM, A0, 1, SSLClient::SSL_ERROR);
  #else
    #include <WiFiClientSecure.h>
    WiFiClientSecure client;  
  #endif

AsyncTelegram2 myBot(client);

TBMessage msg1;

void setup() {
  // put your setup code here, to run once:
pinMode(LED, OUTPUT);

WiFi.begin(ssid[3], password[3]);
//WiFi.begin("Promautomatics_systems","kk11146452");

//WiFi.begin(ssid_, password_);

while ( WiFi.status() != WL_CONNECTED ) 
  {
  delay ( 1000 );
  Serial.print ( "." );
  }
}

void loop() {

  
if (myBot.getNewMessage(msg1))
  {
  handleNewMessages(msg1);      
  }
  
  // put your main code here, to run repeatedly:
  digitalWrite(LED, !digitalRead(LED));
  delay(1000);

}
