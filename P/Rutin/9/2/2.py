# -*- coding: cp1251 -*-
import os

print(os.getcwd())
print("\r")
for folderName,subfolders,filenames in os.walk(os.getcwd()):
    print ("������� ����� - " + folderName)

    for subfolder in subfolders:
        print('�������� ����� ' + folderName + ':' + subfolder)

    for filename in filenames:
        print('���� � ����� ' + folderName + ':' + filename)

    print('')
    #input('')
