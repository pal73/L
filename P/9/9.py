import random
# Создаём бинарный файл
file=open("number_list.bin","wb")
# Объявляем список с числовыми данными
numbers=[random.randint(0,255) for i in range(100)]
# Конвертируем список в массив
barray=bytearray(numbers)
# Записываем массив в файл
file.write(barray)
file.close()
