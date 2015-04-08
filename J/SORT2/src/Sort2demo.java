import java.util.ArrayList;

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

        System.out.println(aList.get(0).firstName.toString()).
        System.out.println(aList.get(1));
        System.out.println(aList.get(2));
        System.out.println(aList.get(3));

        //for(int i = 0; i < input)
    }
}
