/**
 * Created by PAL73 on 20.04.15.
 */
public class Thread2 extends Thread{
    public void run() {
        while(Maintr1.sinhro!=0) {
            if ((Maintr1.sinhro % 2) == 0) {

                System.out.println("Ping");
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
