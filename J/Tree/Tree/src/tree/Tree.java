/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tree;

import java.util.LinkedList;

/**
 *
 * @author PAL73
 */
public class Tree {
    public static boolean isBinary;
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Node root = new Node();
        
        isBinary=true;
        
        //llist.add(new Nodetested());
        NodeCheker.checker(root);
        
        if(isBinary == true) System.out.println(" Фига ");
        else System.out.println(" Нифига ");       
        
    }
    
}
