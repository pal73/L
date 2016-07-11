/**
 * Created by PAL73 on 23.04.15.
 */
public class Tr2mainclass {
    private int mainTemp = 4;


    public static void main(String[] args) {
        Tr2mainclass mc = new Tr2mainclass();

        Thread1 tr1 = new Thread1(mc);
        Thread2 tr2 = new Thread2(mc);

        Thread tr11 = new Thread(tr1);
        Thread tr22 = new Thread(tr2);

        tr11.start();
        tr22.start();

    /*    while(!mc.mainTempIsZero()) {
            try{
                Thread.sleep(4000);
            } catch (InterruptedException e){

            }

        }*/
        while (tr11.isAlive()) {
        }
        ;
        while (tr22.isAlive()) {
        }
        ;
        System.out.println("Stop");
    }


    synchronized boolean pinger() {
        //if((mainTemp%2)==1) {

        System.out.println("Ping" + mainTemp);
        // }

        System.out.println("pi1 " + mainTemp);
        notifyAll();
        System.out.println("pi2 " + mainTemp);
        try {
            System.out.println("pi3 " + mainTemp);
            wait();
            System.out.println("pi4 " + mainTemp);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //mainTemp--;
        if (mainTemp == 0) {
            notifyAll();
            return false;
        }
        return true;
    }

    synchronized boolean ponger() {


        //if((mainTemp%2)==0) {
        //  mainTemp--;

        //}
        //if(mainTemp==0)return false;
        System.out.println("po1 " + mainTemp);
        notifyAll();
        System.out.println("po2 " + mainTemp);
        try {
            System.out.println("po3 " + mainTemp);
            wait();
            System.out.println("po4 " + mainTemp);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Pong" + mainTemp);

        mainTemp--;
        if (mainTemp == 0) {
            notifyAll();
            return false;
        }
        return true;
    }
}
