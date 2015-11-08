package com.example.cyrk;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.View;

/**
 * Created by user on 07.11.2015.
 */
public class CanvasView extends View{
    protected GameManager gameManager;


    public CanvasView(Context context, AttributeSet attrs) {
        super(context, attrs);
        gameManager = new GameManager();

    }



    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        gameManager.onDraw(canvas);

    }
}
