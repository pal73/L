package com.example.myapp;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

public class MyActivity extends Activity {
    private static final String TAG = "MyActivity";
    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        Log.w(TAG,"Hello world1 from console ");
    }

    public void onMyButtonClick(View v)
    {
        Log.w(TAG, v.getClass().getName()); // Тут выведется имя класса того что пришло в обработчик
    }
}
