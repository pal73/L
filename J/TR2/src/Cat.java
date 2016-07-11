/**
 * Created by PAL73 on 28.04.15.
 */
public class Cat extends Animal {

    public void sayTheName() {
        System.out.println("Мяу" + name);
    }

    public void run() {
        System.out.println("смотри, я бегу как кошка");
    }
}

класс Оборотень {
        переменная ктоЯ;

        метод Переключатель{
            если ктоЯ==кошка тогда ктоЯ=собака;
            else ктоЯ=кошка;
            }
        }
        метод Орать{
        если ктоЯ==кошка тогда мяукать;
        если ктоЯ==собака тогда лаять;
        }