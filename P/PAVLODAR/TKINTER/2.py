import tkinter as tk
import tkinter.messagebox as tk_mb

def main():
    main_window = tk.Tk() 
    main_window.geometry("350x200")
     
    tk.mainloop()
    label = tk.Label(main_window,text="Привет", bg = "blue")

    label1 = tk.Label(main_window, text='Привет1', bg = "red")
    label1.pack(side='bottom', ipady=10, fill = tk.X)
    label.pack(side='left', fill = tk.BOTH)
    button1 =   tk.Button(main_window, text = "Нажми", command = button_callback)
    button1.pack(side="bottom")

def button_callback():
    #tk_mb.showinfo("Реакция", "Благодарю что нажали")
    main_window.destroy()
     
main()