import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

/**
 * Created by PAL73 on 08.04.15.
 */
public class Demosort1 {
    public static void main (String[] args) {
        final String[] input = new String[5];
        input[0]="dfshgfjyt";
        input[1]="wryiytiouyi";
        input[2]="p[ouirwey";
        input[3]="nsdiret";
        input[4]="nsdIret";

        System.out.println("На входе:");
        System.out.println(input[0]);
        System.out.println(input[1]);
        System.out.println(input[2]);
        System.out.println(input[3]);
        System.out.println(input[4]);

       /* ArrayList aList = new ArrayList<String>();
        for (int i=0; i<input.length; i++) {
            aList.add(input[i]);
        }*/

        Arrays.sort(input);

        //Collections.sort(aList);

        System.out.println("На выходе:");
        System.out.println(input[0]);
        System.out.println(input[1]);
        System.out.println(input[2]);
        System.out.println(input[3]);
        System.out.println(input[4]);
    }
}
