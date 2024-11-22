# Complete project details at https://RandomNerdTutorials.com/micropython-programming-with-esp32-and-esp8266/

import time
from umqttsimple import MQTTClient
import ubinascii
import machine
import micropython
import network
import esp
esp.osdebug(None)
import gc
gc.collect()

ssid = 'systems_promautomatic'
password = 'bCGz37vn'
mqtt_server = '192.168.1.44'
mqtt_user = ''
mqtt_pass = ''

#EXAMPLE IP ADDRESS
#mqtt_server = '192.168.1.144'
client_id = ubinascii.hexlify(machine.unique_id())
topic_sub = '56'
topic_pub = '178'

last_message = 0
message_interval = 5
counter = 0

station = network.WLAN(network.STA_IF)

station.active(False)
station.active(True)
station.connect(ssid, password)

while station.isconnected() == False:
  pass

print('Connection successful')
print(station.ifconfig())

# Complete project details at https://RandomNerdTutorials.com/micropython-programming-with-esp32-and-esp8266/

def sub_cb(topic, msg):
  print((topic, msg))
  if topic == b'56' :
    print('ESP received ', msg.decode())
    msg = b'Принято значение ' + msg
    client.publish(topic_pub, msg)

def connect_and_subscribe():
  global client_id, mqtt_server, topic_sub
  client = MQTTClient(client_id, mqtt_server, user=mqtt_user, password=mqtt_pass)
  client.set_callback(sub_cb)
  client.connect()
  client.subscribe(topic_sub)
  print('Connected to %s MQTT broker, subscribed to %s topic' % (mqtt_server, topic_sub))
  return client

def restart_and_reconnect():
  print('Failed to connect to MQTT broker. Reconnecting...')
  time.sleep(10)
  machine.reset()

try:
  client = connect_and_subscribe()
except OSError as e:
  restart_and_reconnect()

while True:
  try:
    client.check_msg()
    if (time.time() - last_message) > message_interval:
      msg = b'Hello #%d' % counter
      client.publish(topic_pub, msg)
      print ("publish ", msg)
      last_message = time.time()
      counter += 1
  except OSError as e:
    restart_and_reconnect()