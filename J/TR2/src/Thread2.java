/**
 * Created by PAL73 on 23.04.15.
 */
public class Thread2 implements Runnable{
    Tr2mainclass mc;

    public Thread2(Tr2mainclass mc) {
        this.mc = mc;
    }
    public void run() {
        while (mc.ponger()) {
            System.out.println("2");
        }
        //mc.notify();
    }

}