import java.util.Arrays;


public class Pr1Class {

	static int[] array1 = {1,2,3,4,5};
	static int[] array2 = {10,20,30,40,50};
	
	public static void main(String[] args) {
		System.arraycopy(array1,2,array2,1,2);
		System.out.print(Arrays.toString(array2));
	}
}