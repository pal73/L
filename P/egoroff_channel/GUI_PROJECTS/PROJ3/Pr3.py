
#Знакомство с виджетами. Виджет Label

import tkinter as tk
temp=0

def bt1_actor():
    global temp
    print ("Hello")
    temp=temp+1
    print (temp)
    label1["text"]=f"Мама мыла раму {temp}"

win = tk.Tk()
win.title("Знакомство с Button")
win.geometry("500x500+200+200")


label1=tk.Label(win,text=f"Мама мыла раму {temp}",
                bg="red",
                fg="white")
label1.config(bg="blue",
              font=("MSSanserif1", 20, "bold"),
              padx=30,
              pady=30)
label1.pack()

bt1=tk.Button(win,text="Нвжать",
              command = bt1_actor)
bt1.pack()

win.mainloop()

