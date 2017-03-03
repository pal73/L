from tkinter import *
from tkinter.filedialog import *

def open_file(event):
    op = askopenfilename()
    print(op)
    sizeOfOp=os.path.getsize(op)
    print(sizeOfOp)
    if(op!=''):
        fil=open(op, 'rb') 
        #print(fil.
        buff = fil.read()

        #print (len(buff))
        #print(int.from_bytes(bytes(buff[0]),byteorder='little'))
        #print (type(buff))
        #print(bytes(buff[1]))
        fil.close()
        for i in range(int(sizeOfOp/8)):
            for ii in range(8):
                txt.insert(END,'    {:02X}'.format(buff[i*8+ii]))
                #print( '{:04X}'.format(hex(buff[30])))
                #txt.insert(END, '  ') 
            txt.insert(END, '\n')
root = Tk()
root.title("LC640_COPY")
root.geometry("600x400")

but1 = Button(root,
          text="Открыть порт", #надпись на кнопке
          width=12,height=1, #ширина и высота
          bg="white",fg="blue") #цвет фона и надписи
but2 = Button(root,
          text="Прочитать", #надпись на кнопке
          width=12,height=1, #ширина и высота
          bg="white",fg="blue") #цвет фона и надписи 
but3 = Button(root,
          text="Записать", #надпись на кнопке
          width=12,height=1, #ширина и высота
          bg="white",fg="blue") #цвет фона и надписи 
but4 = Button(root,
          text="Открыть файл", #надпись на кнопке
          width=12,height=1, #ширина и высота
          bg="white",fg="blue") #цвет фона и надписи 
but5 = Button(root,
          text="Сохранить файл", #надпись на кнопке
          width=12,height=1, #ширина и высота
          bg="white",fg="blue") #цвет фона и надписи 
but6 = Button(root,
          text="Прервать", #надпись на кнопке
          width=12,height=1, #ширина и высота
          bg="white",fg="blue") #цвет фона и надписи 
          
txt=Text(root,height=20,width=50,font=('courier new',10),wrap=WORD)
scr1 = Scrollbar(root,command=txt.yview)
txt.configure(yscrollcommand=scr1.set)

#but1.pack()
but1.place(relx=0.1,rely=0.2)
but2.place(relx=0.1,rely=0.3)
but3.place(relx=0.1,rely=0.4)
but4.place(relx=0.1,rely=0.5)
but5.place(relx=0.1,rely=0.6)
but6.place(relx=0.1,rely=0.7)
txt.place(relx=0.3,rely=0.1)
scr1.place(relx=0.95,rely=0.1)


but4.bind("<Button-1>", open_file)

#txt = Text(root,width=40,height=15,font="12")
#txt.pack()


#op = askopenfilename()
##sa = asksaveasfilename()
 
root.mainloop()