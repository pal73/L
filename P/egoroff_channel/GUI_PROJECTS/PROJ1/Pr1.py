# введение в Tkinter

print ('Hello')

import tkinter as tk

win=tk.Tk()
win.title("Мое первое графическое приложение")
win.geometry("500x300+100+100")
photo = tk.PhotoImage(file="images.png")
win.config(bg='red')
#win.bg='red'
win.iconphoto(False,photo)
win.resizable(False,False)
win.mainloop()