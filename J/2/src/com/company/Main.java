package com.company;

class Main {

    public static void main(String[] args) {
	    int lightspeed;
        long days;
        long seconds;
        long distance;

        // Приблизительная скорость света в км в секунду
        lightspeed = 300000;
        days = 1000; //указание количества дней
        seconds = days * 24 * 60 * 60;
        distance = lightspeed * seconds;
        System.out.print ("За " + days + "  дней свет пройдет около ");
        System.out.print (distance + " километров");
    }
}
