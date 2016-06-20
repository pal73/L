/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app_scan;

import java.util.Scanner;
/**
 *
 * @author PAL73
 */
public class App_Scan {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        
        while(true) {
            System.out.println("Введите целое число");

            if(scan.hasNext()) {
                if(scan.hasNextInt()) {
                    int i=scan.nextInt();
                    if ( (i%2)!=0 ) {
                        System.out.println("Вы ввели нечетное число");
                    } else {
                        System.out.println("Вы ввели четное число");
                    }
                } else {
                    scan.next();
                    System.out.println("Вы ввели не целое число");
                }
            }
        }    
    }
    
}
