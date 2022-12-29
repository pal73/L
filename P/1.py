from serial.tools import list_ports
print(
    "\n".join(
        [
            port.device + ': ' + port.description
            for port in list_ports.comports()
        ]))
