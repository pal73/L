package com.example.cyrk;

import android.graphics.Canvas;
import android.graphics.Paint;

/**
 * Created by user on 08.11.2015.
 */
public class GameManager {
    private MainCircle mainCircle;
    private Paint paint;
    public void onDraw(Canvas canvas) {
        canvas.drawCircle(mainCircle.getX(),mainCircle.getY(),mainCircle.getRadius(),paint);
    }

    public GameManager() {
        initMainCircle();
        initPaint();
    }

    private void initPaint() {
        paint = new Paint();
        paint.setAntiAlias(true);
        paint.setStyle(Paint.Style.FILL);
    }

    private void initMainCircle() {
        mainCircle = new MainCircle(200,500);
    }
}
