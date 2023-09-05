

import machine


import time





pin = machine.Pin(2,machine.Pin.OUT)





  
def led_on(_del):
  pin.off()
  time.sleep(_del)
  
def led_off(_del):
  pin.on()
  time.sleep(_del)

