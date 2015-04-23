/**
 * Created by PAL73 on 20.04.15.
 */
public class Thread1 implements Runnable{
    public void run() {
        while(Maintr1.sinhro!=0) {
            if ((Maintr1.sinhro % 2) == 1) {

                System.out.println("Pong");
                Maintr1.sinhro--;
                notify();
                try {
                    wait();
                } catch (InterruptedException e) {

                }
            }
        }
    }
}
