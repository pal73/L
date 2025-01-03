

import machine


import time 





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
    led_on(1)
    led_off(1)
    print(i)