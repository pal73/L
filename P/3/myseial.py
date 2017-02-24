import serial

with serial.Serial('COM10', 19200, timeout=1) as port:
    port.write(b'hello')

