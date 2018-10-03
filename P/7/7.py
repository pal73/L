import win32gui
import win32process
import win32api
import sys
import glob
import serial
import time
import re


def serial_ports():
    """ Lists serial port names

        :raises EnvironmentError:
            On unsupported or unknown platforms
        :returns:
            A list of the serial ports available on the system
    """
    if sys.platform.startswith('win'):
        ports = ['COM%s' % (i + 1) for i in range(256)]
    elif sys.platform.startswith('linux') or sys.platform.startswith('cygwin'):
        # this excludes your current terminal "/dev/tty"
        ports = glob.glob('/dev/tty[A-Za-z]*')
    elif sys.platform.startswith('darwin'):
        ports = glob.glob('/dev/tty.*')
    else:
        raise EnvironmentError('Unsupported platform')

    result = []
    for port in ports:
        try:
            s = serial.Serial(port)
            s.close()
            result.append(port)
        except (OSError, serial.SerialException):
            pass
    

    result_ = ""
    
    

    for port in result:
        try:
            s=serial.Serial(port,9600,timeout=3)
            time.sleep(1.5);
            s.write(b"Handshake\n")
            p=s.readline()
            if p!="" :
                print(p)
            s.close()
            #if p==b"handshake\r\n":
            if p.find(b"hand")!= -1:
                global wrk_port
                wrk_port=port
            #else:
                #wrk_port="2"
            #print(wrk_port)
        except (OSError, serial.SerialException):
            pass

    return result

wrk_port=" "

if __name__ == '__main__':
    print(serial_ports())

print(wrk_port)

if wrk_port!=" ":
    print (wrk_port)
    s=serial.Serial(wrk_port,9600)
    while (True):
        time.sleep(0.5)
        #s.write(b"Handshake\n")
        hWindow = win32gui.GetForegroundWindow()
        idProcess = win32process.GetWindowThreadProcessId(hWindow)
        #print (idProcess)
        #Result=(win32api.GetKeyboardLayout(idProcess));
        Result=(win32api.GetKeyboardLayout(idProcess[0]));
        print (Result)
    ##with serial.Serial('COM4', 19200, timeout=1) as port:
        ##port.write(b'hello')
    ##time.sleep(1)
        if Result == 67699721:
            s.write(b"latino\n")
        else:
            s.write(b"kyrilc\n")
        
