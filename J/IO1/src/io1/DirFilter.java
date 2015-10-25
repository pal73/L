/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package io1;

import java.util.regex.Pattern;

/**
 *
 * @author PAL73
 */
public class DirFilter implements FilenameFilter {
    private Pattern pattern;
    public DirFilter (String regex) {
        pattern = Pattern.compile(regex);
    }
    public boolean accept (File.dir, String name )
}
