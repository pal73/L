f = open('2.bin', 'rb')

# Получить одну строку из бинарного файла
d = f.read()
#print(type(d))
#print (d[0])
#print (d[1])
c=f.tell()
print(c)

#L2 = []

# 3.3. Обход строк файла, конвертирование и добавление в список L2
#for ln in f:
    #x = bytes(ln) # взять число
    #L2 = L2 + [x] # Добавить число к списку

# 3.4. Вывести список
#print("L2 = ", L2) # L2 = [1.5, 2.8, 3.3]
i=0
f.close()
for l in range(0,100,10):
    i=i+1
    print (d[l], '\t', d[l+1], '\t',d[l+2], '\t',l)
    
