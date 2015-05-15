/**
 * Created by PAL73 on 23.04.15.
 */
public class Syncclass {

    public synchronized void one(){
        System.out.println("One is sync runing");
        try {
            Thread.sleep(5 * 1000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            wait();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("one method is end");
    }

    public synchronized void two(){
        System.out.println("two sync is running");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        notify();
    }

}

