/**
 * Created by PAL73 on 20.04.15.
 */
public class Maintr1 {
    public static int sinhro=11;
    static Thread1 tr1;
    //Thread2 tr2;
    public static void main (String[] args){
        tr1 = new Thread1();
        Thread2 tr2 = new Thread2();

        Thread tr11 = new Thread(tr1);
        //Thread tr22 = new Thread(tr2);

        tr11.start();
        tr2.start();
    }
}
