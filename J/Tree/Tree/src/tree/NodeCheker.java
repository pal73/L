/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tree;

/**
 *
 * @author PAL73
 */
public class NodeCheker {
    public static void checker (Node checkedNode) {
        //llist.add(new Nodetested());
        
        int tempRightValue, tempLeftValue; 
        try {
            tempRightValue = checkedNode.right.value; 
        } catch (NullPointerException e) {
            tempRightValue=0;
        }

        try {
            tempLeftValue = checkedNode.left.value; 
        } catch (NullPointerException e) {
            tempLeftValue=0;
        }
                
        if((tempLeftValue>checkedNode.value)&&(checkedNode.value>tempRightValue)) {
            try { 
                NodeCheker.checker(checkedNode.right);
            } catch (NullPointerException e) {
                //
            }

            try { 
                NodeCheker.checker(checkedNode.left);
            } catch (NullPointerException e) {
                //
            }
        } else {
            Tree.isBinary=false;
        }
        
    }
    
    
}
