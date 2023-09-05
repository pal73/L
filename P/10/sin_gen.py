import sys
input_string = input("Количество периодов - ")
num_of_per = int(input_string)
print(num_of_per)
input_string = input("Количество отсчетов на период - ")
sampl_per_per = int(input_string)
print(sampl_per_per)
num_of_sampl = sampl_per_per*num_of_per
print(num_of_sampl)
byte_depth=0
for i in range(3):
    input_string = input("Разрядность, байт (1, 2, 4) ")
    if input_string == '1' or input_string == '2' or input_string == '4':
        byte_depth= int(input_string)
        break
    if i != 2:
        print('Введенное значение некорректно, попробуйте еще раз')
    print (i)
if i==2:
    print('Вы ввели неправильное значение три раза, программа прекращает свою работу')
    sys.exit()                  
print(byte_depth)
