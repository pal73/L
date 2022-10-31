# -*- coding: cp1251 -*-
import os

print(os.getcwd())
print("\r")
for folderName,subfolders,filenames in os.walk(os.getcwd()):
    print ("Текущая папка - " + folderName)

    for subfolder in subfolders:
        print('ПОДПАПКА ПАПКИ ' + folderName + ':' + subfolder)

    for filename in filenames:
        print('ФАЙЛ В ПАПКЕ ' + folderName + ':' + filename)

    print('')
    #input('')
