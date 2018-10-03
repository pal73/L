import serial

with serial.Serial('COM4', 19200, timeout=1) as port:
    port.write(b'hello')

