/**
 * Created by PAL73 on 23.04.15.
 */
public class Thread1 implements Runnable{
    Tr2mainclass mc;

    public Thread1(Tr2mainclass mc) {
        this.mc = mc;
    }

    public void run() {
        while (mc.mainTempIsZero() != true) {
            if (mc.mainTempIsOdd()) {
                System.out.println("Ping");
                notify();
                try {
                    wait();
                } catch (InterruptedException e) {

                }
            } else {
                notify();
                try {
                    wait();
                } catch (InterruptedException e) {

                }
            }
        }
    }
}
