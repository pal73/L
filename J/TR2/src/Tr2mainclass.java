/**
 * Created by PAL73 on 23.04.15.
 */
public class Tr2mainclass {
    private int mainTemp=10;


    public static void main (String[] args) {
        Tr2mainclass mc = new Tr2mainclass();

        Thread1 tr1 = new Thread1(mc);
        Thread2 tr2 = new Thread2(mc);

        Thread tr11 = new Thread(tr1);
        Thread tr22 = new Thread(tr2);

        tr11.start();
        tr22.start();

        while(!mc.mainTempIsZero()) {
            try{
                Thread.sleep(4000);
            } catch (InterruptedException e){

            }

        }
        System.out.println("Stop");
    }

    synchronized boolean mainTempIsOdd() {
        if((mainTemp%2)==0) {
            mainTemp--;
            return true;
        }
        return false;
    }

    synchronized boolean mainTempIsEven() {
        if((mainTemp%2)==1) {
            mainTemp--;
            return true;
        }
        return false;
    }
    synchronized boolean mainTempIsZero() {
        if(mainTemp==0) {
            return true;
        }
        return false;
    }
}
