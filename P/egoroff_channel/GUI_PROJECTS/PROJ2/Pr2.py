
#Знакомство с виджетами. Виджет Button

import tkinter as tk

win = tk.Tk()
win.title("Знакомство с Label")
win.geometry("500x500+200+200")

label1=tk.Label(win,text="Мама мыла раму",
                bg="red",
                fg="white")
label1.config(bg="blue",
              font=("MSSanserif1", 20, "bold"),
              padx=30,
              pady=30)
label1.pack()



win.mainloop()

