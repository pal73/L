# Это игра по угадыванию чисел.
import random
import PySimpleGUI as sg

guessesTaken = 0

#print('Привет! Как тебя зовут?')
win_=sg.Window('Привет! Как тебя зовут?', [ [sg.Input()], [sg.OK(), sg.Cancel()] ])
event, myName = win_.Read()
#sg.Popup('Hello From PySimpleGUI!', 'This is the shortest GUI program ever!')
win_.Close()
myName=myName[0];
print(myName)
#myName = input()

number = random.randint(1, 20)
print('Что ж, ' + myName + ', я загадываю число от 1 до 20.')

head='Что ж, ' + myName + ', я загадываю число от 1 до 20. Попробуй угадать.'

for guessesTaken in range(6):
    
    win_=sg.Window(head, [ [sg.Input()], [sg.OK(), sg.Cancel()] ]) # Четыре пробела перед именем функции print
    event, answer = win_.Read()
    win_.Close()

    guess = int(answer[0])
    #guess = int(guess)
    
    if guess < number:
        head = 'Твое число слишком маленькое.' # Восемь пробелов перед именем функции print
    
    if guess > number:
        head = 'Твое число слишком большое.'
    
    if guess == number:
        break

if guess == number:
    guessesTaken = str(guessesTaken + 1)
    print('Отлично, ' + myName + '! Ты справился за ' + guessesTaken + ' попытки!')

if guess != number:
    number = str(number)
    print('Увы. Я загадала число ' + number + '.')
