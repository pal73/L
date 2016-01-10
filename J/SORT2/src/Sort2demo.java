import java.util.ArrayList;
import java.util.Collections;

/**
 * Created by PAL73 on 08.04.15.
 */
public class Sort2demo {
    public static void main (String[] args) {
        Inputstr[] inputStr = new Inputstr[4];

        /*inputStr[0] = new Inputstr("dfhdfh","yturyu",23);
        inputStr[1] = new Inputstr("fghdfh","12uryu",24);
        inputStr[2] = new Inputstr("dfhfth","yttyuu",25);
        inputStr[3] = new Inputstr("1fhdfh","ytulkj",26);*/

        ArrayList aList = new ArrayList<Inputstr>();

        aList.add(new Inputstr("dfhdfh","yturyu",23));
        aList.add(new Inputstr("fghdfh","12uryu",24));
        aList.add(new Inputstr("dfhfth","yttyuu",25));
        aList.add(new Inputstr("1fhdfh","ytulkj",26));

        System.out.println("На входе:");

        System.out.println(((Inputstr)aList.get(0)).firstName.toString() + "   " + ((Inputstr)aList.get(0)).secondName.toString() + "   " + ((Inputstr)aList.get(0)).age);
        System.out.println(((Inputstr)aList.get(1)).firstName.toString() + "   " + ((Inputstr)aList.get(1)).secondName.toString() + "   " + ((Inputstr)aList.get(1)).age);
        System.out.println(((Inputstr)aList.get(2)).firstName.toString() + "   " + ((Inputstr)aList.get(2)).secondName.toString() + "   " + ((Inputstr)aList.get(2)).age);
        System.out.println(((Inputstr)aList.get(3)).firstName.toString() + "   " + ((Inputstr)aList.get(3)).secondName.toString() + "   " + ((Inputstr)aList.get(3)).age);

        //for(int i = 0; i < input)

        //Collections
    }
}
