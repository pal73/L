import tkinter
import random

#constants
WIDTH=640
HEIGHT=480
BG_COLOR="white"
ZERO=0
COLORS=['aqua', 'fuchsia', 'pink', 'yellow', 'gold', 'chartreuse']

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
        fill=self.color)

    def hide(self):
        canvas.create_oval(self.x-self.r,self.y-self.r,self.x+self.r,self.y+self.r,
        fill=BG_COLOR,outline = BG_COLOR)
        
    def is_collision(self,ball):
        a = abs(self.x-ball.x+self.dx)
        b = abs(self.y-ball.y+self.dy)
        return (a**2+b**2)**0.5 <= self.r+ball.r
        
    def move(self):
        #print(self.x, self.y, self.dx, self.dy)
        #Столкновения со стенами
        if (self.x+self.r+self.dx>=WIDTH)or(self.x-self.r+self.dx<=ZERO): self.dx=-self.dx
        if (self.y+self.r+self.dy>=HEIGHT)or(self.y-self.r+self.dy<=ZERO): self.dy=-self.dy
        #Столкновения с другими шарами
        for b in balls:
            if self.is_collision(b):
                b.hide()
                balls.remove(b)
                self.dx=-self.dx
                self.dy=-self.dy
                
        self.hide()
        self.x+=self.dx
        self.y+=self.dy
        self.draw()
            
#mouse events
def mouse_click(event):
    print(event.x,event.y,event.num)
    global main_ball
    if event.num==1:
        if 'main_ball' not in globals():
            main_ball=Balls(event.x,event.y,30,'blue',1,1)
            main_ball.draw()
        else:
            if main_ball.dx*main_ball.dy>0:
                main_ball.dy=-main_ball.dy
            else: 
                main_ball.dx=-main_ball.dx
    elif event.num==3:
        if main_ball.dx*main_ball.dy>0:
            main_ball.dx=-main_ball.dx
        else: 
            main_ball.dy=-main_ball.dy
    else: main_ball.hide()
#create list of balls 
def create_list_of_balls(number):
    lst=[]
    while len(lst)<number:
        next_ball=Balls(
                    random.choice(range(0,WIDTH)),
                    random.choice(range(0,HEIGHT)),
                    random.choice(range(15,35)),
                    random.choice(COLORS)) 
        lst.append(next_ball)
        next_ball.draw()
    return lst
#main circle game
def main():
    #print("main")
    if 'main_ball' in globals():
        main_ball.move()
    if(len(balls)==0):
        canvas.create_text(WIDTH/2,HEIGHT/2,text="ТЫ ПОБЕДИЛ!!!",font="Arial 20",
        fill=main_ball.color)
        main_ball.dx=0
        main_ball.dy=0
    root.after(10,main)
    
root=tkinter.Tk()
root.title("ddddd")        
canvas = tkinter.Canvas(root,width=WIDTH,height=HEIGHT,bg=BG_COLOR)
canvas.pack()
canvas.bind('<Button-1>',mouse_click)
canvas.bind('<Button-2>',mouse_click,'+')
canvas.bind('<Button-3>',mouse_click,'+')
balls=create_list_of_balls(5)
main()
root.mainloop()

