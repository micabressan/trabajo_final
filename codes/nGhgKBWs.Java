package lefrotit.greetingcard2018;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
public class PostCardView extends View {
    @Override
    public boolean onTouchEvent(MotionEvent event) {
        invalidate();
        return super.onTouchEvent(event);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        Paint p1 = new Paint();
        p1.setColor(Color.WHITE);
        Paint p2 = new Paint();
        p2.setColor(Color.DKGRAY);
        Paint p3 = new Paint();
        p3.setColor(Color.BLACK);


        super.onDraw(canvas);
        canvas.drawColor(Color.BLUE);
        float w = canvas.getWidth();
        float h = canvas.getHeight();

        for (int i = 0; i < 10; i++) {

            float x = (float) Math.random() * w;
            float y = (float) Math.random() * h;
            float r = 5 + (float) Math.random() * w / 30;
            canvas.drawCircle(x, y, r, p1);

            x = (float) Math.random() * w;
            y = (float) Math.random() * h;
            r = 5 + (float) Math.random() * w / 30;
            canvas.drawCircle(x, y, r, p2);

            x = (float) Math.random() * w;
            y = (float) Math.random() * h;
            r = 5 + (float) Math.random() * w / 30;
            canvas.drawCircle(x, y, r, p3);


        }
    }

    public PostCardView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }
}