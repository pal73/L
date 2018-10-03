#include "FastLED.h"

#define NUM_LEDS 1 //this defines the number of LED Segments in the Strip

#define DATA_PIN 2 //plug the green wire of the TM1803 Radioshack Strip into Pin 7

CRGB leds[NUM_LEDS];
#define COLOR_ORDER GRB

#define led 13
String input_string = "";
const String Led_off = "switch led off";
const String Led_on = "switch led on";

bool led_running;
long loop_cnt;
bool led_out;
void setup() {
  FastLED.addLeds<WS2812, DATA_PIN, COLOR_ORDER>(leds, NUM_LEDS);
  Serial.begin(9600);
leds[0] = CRGB::White;
}

void loop() 
  {
  //loop_cnt++;
  //if(loop_cnt>=100000)
    //{
   // loop_cnt=0;
   // led_out=!led_out;
  //  //digitalWrite(led,!digitalRead(led));
  //  digitalWrite(led,led_out);
   // }
     
  FastLED.show(); 
  while (Serial.available() > 0) {
    char c = Serial.read();
    if (c == '\n') { 
      //Serial.print("Input_string is: ");
      //Serial.println(input_string);
      switch ( parse(input_string, Led_off, Led_on) ) {
        case 10:
          led_running=false;
          Serial.println("Switching off is done");
          leds[0] =  CRGB::Red;
          break;
        case 11:
          led_running=true;
          Serial.println("Switching on is done");
          leds[0].setRGB(200, 200,200);//0xaaaaaa;//CRGB::Tomato;
          break;
        case 13:
          led_running=true;
          Serial.println("handshake");
           digitalWrite(led,!digitalRead(led));
          break;
        case 14:
          //leds[0].setRGB(255, 255,255);//0xaaaaaa;//CRGB::Tomato;
          leds[0] = CRGB::White;
          break;
        case 15:
          leds[0].setRGB(255, 0,0);//0xaaaaaa;//CRGB::Tomato;
          break;          
        case 0:
          Serial.println("invalid String");
          break;
      }
      input_string = "";
      digitalWrite(led, led_running);
     
    } else {
      input_string += c;

    }
  }
  }

byte parse(String input_string, const String Led_off, const String Led_on) 
  {
  if (input_string.equals(Led_off) == true) 
    {
    return 10;
    }
  else if (input_string.equals(Led_on) == true) 
    {
    return 11;
    }
  else if (input_string.equals("Handshake") == true) 
    {
    return 13;
    }    
  else if (input_string.equals("latino") == true) 
    {
    return 14;
    }    
  else if (input_string.equals("kyrilc") == true) 
    {
    return 15;
    }    
  else return 0;
}
