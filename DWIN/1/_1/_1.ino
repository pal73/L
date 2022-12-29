#include <GyverTimers.h>

int real_period;
short t2_cnt0;
bool b1Hz,bLED;
// digital pin 2 has a pushbutton attached to it. Give it a name:
int pushButton = 2;
int plazma;

// the setup routine runs once when you press reset:
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  real_period=Timer2.setPeriod(10000);
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  // make the pushbutton's pin an input:
  pinMode(pushButton, INPUT);
  //Timer1.enableISR(CHANNEL_A, 180);
  Timer2.enableISR();
}

// the loop routine runs over and over again forever:
void loop() {
 
  // read the input pin:
  int buttonState = digitalRead(pushButton);
  // print out the state of the button:
  //Serial.println(real_period);
  //delay(1);        // delay in between reads for stability
  if(b1Hz)
    {
    b1Hz=0;
    bLED=!bLED;
    digitalWrite(LED_BUILTIN,bLED);
    Serial.println("plazma="+ (String)plazma++);
    }
}

 ISR(TIMER2_A) 
  {
  if(++t2_cnt0>=100)
    {
    t2_cnt0=0;
    b1Hz=1;
    }
  }



