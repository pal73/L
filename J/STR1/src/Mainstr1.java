/**
 * Created by PAL73 on 29.04.15.
 */
public class Mainstr1 {
    static int inputStrLength;
    static final String inputStr = "Удачи тебе дед макар"; //new String();/**/
    static char[] inputchar;
    static int shiftCouner = 0;

    public static void main(String[] args) {

        inputStrLength = inputStr.length();
        inputchar = new char[inputStrLength];
        for (int i = 0; i < inputStrLength; i++) {
            inputchar[i] = inputStr.charAt(i);
        }

        System.out.println(inputchar.toString());



        int shiftPosition=inputStrLength;

        while (shiftCouner < inputStrLength) {
            int indexOfFirstSpace = findIndexOfFirstSpace(inputchar);


            for (int i1=0; i1<indexOfFirstSpace;i1++ ) {
                shiftSimbol(shiftPosition);

            }
            shiftPosition-=indexOfFirstSpace;
            if(shiftPosition>0) shiftSimbol(shiftPosition);
            shiftPosition--;
        }

    System.out.println(inputchar.toString());
    }

    public static int findIndexOfFirstSpace(char input[]) {
        int a;

        for (a=0; a<inputStrLength;a++) {
            if(input[a]==' ') {
                break;
            }

        }
        return a;
    }

    public static void shiftSimbol (int toPosition) {
        char tempSimb = inputchar[0];
        for (int iii=1; iii<toPosition;iii++ ){
            inputchar[iii-1]=inputchar[iii];
        }
        inputchar[toPosition-1]=tempSimb;
        shiftCouner++;
    }


}
