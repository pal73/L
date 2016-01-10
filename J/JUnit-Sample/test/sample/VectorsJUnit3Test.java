/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample;

import junit.framework.TestCase;

/**
 *
 * @author PAL73
 */
public class VectorsJUnit3Test extends TestCase {
    
    public VectorsJUnit3Test(String testName) {
        super(testName);
    }

    /**
     * Test of equal method, of class Vectors.
     */
    public void testEqual() {
        System.out.println("equal");
        int[] a = {1,2,3,4};
        int[] b = {1,2,3,4};
        boolean expResult = true;
        boolean result = Vectors.equal(a, b);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }

    /**
     * Test of scalarMultiplication method, of class Vectors.
     */
    public void testScalarMultiplication() {
        System.out.println("scalarMultiplication");
        int[] a = null;
        int[] b = null;
        int expResult = 0;
        int result = Vectors.scalarMultiplication(a, b);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
