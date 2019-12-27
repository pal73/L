/*
    This sketch demonstrates how to set up a simple HTTP-like server.
    The server will set a GPIO pin depending on the request
      http://server_ip/gpio/0 will set the GPIO2 low,
      http://server_ip/gpio/1 will set the GPIO2 high
    server_ip is the IP address of the ESP8266 module, will be
    printed to Serial when the module is connected.
*/

#include <ESP8266WiFi.h>

const char* ssid = "MikroTik-FDCA26";
const char* password = "malovato";

#define Led   2

// Create an instance of the server
// specify the port to listen on as an argument
WiFiServer server(80);

void setup() {
  Serial.begin(115200);
  delay(10);

  // prepare GPIO2
  pinMode(Led, OUTPUT);
  digitalWrite(Led, 0);

  pinMode(4, OUTPUT);
  analogWrite(4,300);

  // Connect to WiFi network
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");

  // Start the server
  server.begin();
  Serial.println("Server started");

  // Print the IP address
  Serial.println(WiFi.localIP());
  Serial.println(Led);
}

void loop() {
  // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  // Wait until the client sends some data
  Serial.println("new client");
  while (!client.available()) {
    delay(1);
  }

  // Read the first line of the request
  String req = client.readStringUntil('\r');
  Serial.println(req);
  client.flush();

  // Match the request
  int val;

  Serial.println(req.length());
  
  if (req.indexOf("/gpio/0") != -1) {
    val = 0;
    digitalWrite(Led, val);
  } else if (req.indexOf("/gpio/1") != -1) {
    val = 1;
    digitalWrite(Led, val);
  } else if (req.indexOf("/pwm/") != -1) {
    String reqreq = req.substring(req.indexOf("/pwm/") + 5,req.indexOf("HTTP") - 1);
    Serial.println(reqreq);
    Serial.println(reqreq.length());
    Serial.println(reqreq.toInt());
    analogWrite(Led,reqreq.toInt());
    //val = 1;
  }else {
    Serial.println("invalid request");
    client.stop();
    return;
  }

  // Set GPIO2 according to the request


  client.flush();

  // Prepare the response
  String s = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>\r\nGPIO is now ";
  s += (val) ? "high" : "low";
  s += "</html>\n";

  // Send the response to the client
  client.print(s);
  delay(1);
  Serial.println("Client disonnected");
  

  // The client will actually be disconnected
  // when the function returns and 'client' object is detroyed
}
