/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package swing1;

import javax.swing.*;

/**
 *
 * @author PAL73
 */
public class SwingDemo {
    SwingDemo() {
        JFrame jfrm = new JFrame("A Simple Swing Program");
        
        jfrm.setSize(275,100);
        
        jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        JLabel jlab = new JLabel("Swing powers modern JAVA GUI");
        
        jfrm.getContentPane().add(jlab);
        
        jfrm.setVisible(true);
    }
    
    public static void main (String[] args) {
      /*  SwingUtilities.invokeLater(new Runnable() {
			public void run(){
				new SwingDemo();
			}
		});*/
        System.out.println ("Hello World");
    }
    
}
    
