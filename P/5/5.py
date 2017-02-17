import tkinter

#constants
WIDTH=640
HEIGHT=480
BG_COLOR="white"


#balls class
class Balls():
    def __init__(self,x,y,r,color,dx=0,dy=0):
        self.x=x
        self.y=y
        self.r=r
        self.color=color
        self.dx=dx
        self.dy=dy
    
    def draw(self):
        canvas.create_oval(self.x-self.r,self.y-self.r,self.x+self.r,self.y+self.r,
        self.color)
        
#mouse events
def mouse_click(event):
    print(event.x,event.y,event)
    
root=tkinter.Tk()
root.title("ddddd")        
canvas = tkinter.Canvas(root,width=WIDTH,height=HEIGHT,bg=BG_COLOR)
canvas.pack()
canvas.bind('<Button-1>',mouse_click)
canvas.bind('<Button-2>',mouse_click,'+')
canvas.bind('<Button-3>',mouse_click,'+')
root.mainloop()

