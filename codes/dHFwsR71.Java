ShootingGameFinal: Todo’s

SoundEffect.java
mSoundPoolMap.put(SOUND_GUY,mSoundPool.load(context,R.raw.beep4,2));
mSoundPoolMap.put(SOUND_BULLET,mSoundPool.load(context,R.raw.beep9,3));

AndroidGuy.java
SoundEffects.INSTANCE.playSound(SoundEffects.SOUND_GUY);

Bullet.java	
SoundEffects.INSTANCE.playSound(SoundEffects.SOUND_BULLET);

Full code:
.........................................................................................................................................................
SoundEffect.java
package hk.ust.cse.comp107x.shootinggamefinal;

import android.annotation.TargetApi;
import android.content.Context;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.media.SoundPool;
import android.os.Build;
import android.util.Log;

import java.util.HashMap;

/**
* Created by muppala on 26/5/15.
* This is an implementation of a Java Singleton class using the Enum approach. This creates
* a single instance of the class that can be accessed anywhere using SoundEffects.INSTANCE
*/

public enum SoundEffects {

INSTANCE;

public static final int SOUND_EXPLOSION=1;
public static final int SOUND_GUY=2;
public static final int SOUND_BULLET=3;

Context mContext;

private SoundPool mSoundPool;
private HashMap<Integer, Integer> mSoundPoolMap;
private AudioManager mAudioManager;
private int streamVolume;

@SuppressWarnings("deprecation")
@TargetApi(Build.VERSION_CODES.LOLLIPOP)
public void setContext(Context context) {

mContext = context;

if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
AudioAttributes audioAttributes = new AudioAttributes.Builder()
.setUsage(AudioAttributes.USAGE_GAME)
.setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
.build();

mSoundPool = new SoundPool.Builder()
.setMaxStreams(5)
.setAudioAttributes(audioAttributes)
.build();
} else {
mSoundPool = new SoundPool(5, AudioManager.STREAM_MUSIC, 0);
}

mSoundPoolMap = new HashMap<Integer, Integer>();
mSoundPoolMap.put(SOUND_EXPLOSION, mSoundPool.load(context, R.raw.explosion,1));
// TODO Add sounds corresponding to the bullet and Android Guy
mSoundPoolMap.put(SOUND_GUY,mSoundPool.load(context,R.raw.beep4,2));
mSoundPoolMap.put(SOUND_BULLET,mSoundPool.load(context,R.raw.beep9,3));
mAudioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
streamVolume = mAudioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);

}

public int getNumSounds() {
return mSoundPoolMap.size();
}

public int playSound(int sound) {
int retval = mSoundPool.play(mSoundPoolMap.get(sound),streamVolume, streamVolume, 100, 0, 1f);
return retval;
}
}

AndroidGuy.java
package hk.ust.cse.comp107x.shootinggamefinal;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.RectF;

/**
* Created by muppala on 23/5/15.
*/
public class AndroidGuy {
float x; // Guy's top left corner (x,y)
float y;
float stepX = 10; // Guy's step in (x,y) direction
float stepY = 5; // gives speed of motion, larger means faster speed
int lowerX, lowerY, upperX, upperY; // boundaries

Bitmap android_guy;

private Context mContext;

// Constructor
public AndroidGuy(int color, Context c) {

mContext = c;

// create a bitmap from the supplied image (the image is the icon that is part of the app)
android_guy = Bitmap.createScaledBitmap(BitmapFactory.decodeResource(mContext.getResources(),
R.mipmap.ic_launcher),50,50, false);

}

public void setBounds(int lx, int ly, int ux, int uy) {
lowerX = lx;
lowerY = ly;
upperX = ux;
upperY = uy;

x = (float) ((upperX-50)*Math.random());
y = 0;
}

public boolean move() {
// Get new (x,y) position. Movement is always in vertical direction downwards
y += stepY;
// Detect when the guy reaches the bottom of the screen
// restart at a random location at the top of the screen
if (y + 50 > upperY) {
x = (float) ((upperX-50)*Math.random());
y = 0;
// TODO Make the sound corresponding to the Android Guy falling down the bottom of screen
SoundEffects.INSTANCE.playSound(SoundEffects.SOUND_GUY);
return true;
}
else
return true;
}

// When you reset, starts the Android Guy from a random X co-ordinate location
// at the top of the screen again
public void reset() {
x = (float) ((upperX-50)*Math.random());
y = 0;
}

// Returns the rectangle enclosing the Guy. Used for collision detection
public RectF getRect() {
return new RectF(x,y,x+50,y+50);
}

public float getX() {
return x;
}

public float getY() {
return y;
}

public void draw(Canvas canvas) {

canvas.drawBitmap(android_guy, x, y, null);
}
}

Bullet.java
package hk.ust.cse.comp107x.shootinggamefinal;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.RectF;

/**
* Created by muppala on 23/5/15.
*/
public class Bullet {
float radius = 5; // Bullet's radius
float x; // Bullet's center (x,y)
float y;
float stepX = 10; // Bullet's step of motion in (x,y) direction
float stepY = 5; // gives speed of motion, larger means faster speed
int lowerX, lowerY, upperX, upperY;
private Paint paint; // The paint style, color used for drawing

private Context mContext;

// Constructor
public Bullet(int color, Context c, float startx, float starty) {
paint = new Paint();
paint.setColor(color);

mContext = c;
x = startx;
y = starty;
}

public void setBounds(int lx, int ly, int ux, int uy) {
lowerX = lx;
lowerY = ly;
upperX = ux;
upperY = uy;
}

// Rectangle enclosing the bullet. Used for collision detection with Guy
public RectF getRect() {
return new RectF(x-radius,y-radius,x+radius,y+radius);
}

// Move the bullet upwards by stepY every time. This creates the upward motion.
public boolean move() {
// Get new (x,y) position
y -= stepY;
// Detect when the bullet reaches the top ofhte screen
// then remove the bullet
if (y - radius < 0) {
// TODO Make the sound corresponding to the bullet leaving from top of screen
SoundEffects.INSTANCE.playSound(SoundEffects.SOUND_BULLET);

return false;
}
else
return true;
}

// draw the bullet on the canvas
public void draw(Canvas canvas) {
canvas.drawCircle(x, y, radius, paint);
}
}