import win32gui
import win32process
import win32api
import time
import serial
while 1:
    hWindow = win32gui.GetForegroundWindow()
    idProcess = win32process.GetWindowThreadProcessId(hWindow)
    #print (idProcess)
    #Result=(win32api.GetKeyboardLayout(idProcess));
    Result=(win32api.GetKeyboardLayout(idProcess[0]));
    print (Result)
    with serial.Serial('COM10', 19200, timeout=1) as port:
        port.write(b'hello')
    time.sleep(1)
