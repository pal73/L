package com.example.cyrk;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Point;
import android.util.AttributeSet;
import android.view.Display;
import android.view.View;
import android.view.WindowManager;

/**
 * Created by user on 07.11.2015.
 */
public class CanvasView extends View{
    private static int height;
    private static int width;
    protected GameManager gameManager;


    public CanvasView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initWidthAndHight(context);
        gameManager = new GameManager(this, width, height);

    }

    private void initWidthAndHight(Context context) {
        WindowManager windowManager = (WindowManager) context.getSystemService(context.WINDOW_SERVICE);
        Display display = windowManager.getDefaultDisplay();
        Point point = new Point();
        display.getSize(point);
        width = point.x;
        height = point.y;

    }


    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        gameManager.onDraw(canvas);

    }
}
