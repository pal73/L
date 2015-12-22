/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.Console;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author PAL73
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Console console = System.console();
        if(console != null) {
            Calendar c = new GregorianCalendar();
            console.printf("Сайт %1$s%n", "Prologistic.com.ua");
            console.printf("Текущее время: %1$tm %1$te,%1$tY%n", c); //печатаем "Текущее время: 13 12,2015"
            console.flush();
        } else {
            System.out.println("Объект Console не получен");
        }
        
    }
    
}
