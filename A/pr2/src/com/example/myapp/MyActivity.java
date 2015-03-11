package com.example.myapp;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;


public class MyActivity extends Activity {
    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        Log.w("dddd","Hello world1 from console ");
    }

    public void onMyButtonClick(View view)
    {
        Log.w("dddd", "Нажата кнопка ");
    }
}
