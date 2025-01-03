

import machine


import time 

from machine import UART

u1=UART(1, baudrate = 9600, tx=9, rx=10)
u1.init()
pin = machine.Pin(8,machine.Pin.OUT)

i=0;

 

  
def led_on(_del):
  pin.off()
  time.sleep(_del)
  
def led_off(_del):
  pin.on()
  time.sleep(_del)


while True:
    i+=1;
    led_on(0.1)
    led_off(1)
    u1.write('helloj')
    print(i)