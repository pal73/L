import os

inputStr=input("Введите текст сообщения:")
print(inputStr)
outputStr=""
for i in inputStr:
    a="%04X" % ord(i)
    #b=a[2:]+a[:2]
    outputStr+=a
print(outputStr)
inputStr=input("Введите номер получателя:")
outputStr=""
for i in inputStr:
    if i.isdigit() :
        outputStr+=i
if len(outputStr)%2 != 0:
    outputStr+="F"
outputStr_=""
for i in range(0,len(outputStr),2):
    outputStr_+=outputStr[i+1]+outputStr[i]
print (outputStr_)