/**
 * Created by PAL73 on 30.04.15.
 */
public class Test {
    class A {
        String str = "ab";

        A() {
            printLength();
        }

        void printLength() {
            System.out.println(str.length());
        }
    }

    class B extends A {
        String str = "abc";

        void printLength() {
            System.out.println(str.length());
        }
    }

    public static void main(String[] args) {
        new Test().new B();
    }
}
