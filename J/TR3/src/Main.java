/**
 * Created by PAL73 on 23.04.15.
 */
public class Main {

    /**
     * @param args
     */
    public static void main(String[] args) {
        final Syncclass sync = new Syncclass();

        new Thread(new Runnable() {

            public void run() {
                for (; ; ) {
                    sync.one();
                }

            }
        }).start();

        new Thread(new Runnable() {

            public void run() {
                for (; ; ) {
                    sync.two();
                }

            }
        }).start();
    }
}
