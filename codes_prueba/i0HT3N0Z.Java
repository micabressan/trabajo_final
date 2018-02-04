package pong;

import java.awt.Color;
import java.awt.Graphics;
import java.util.Timer;
import java.util.TimerTask;

public class HumanPaddle implements Paddle, Runnable {
	float y, yVel;
	boolean upAccel, downAccel;
	int player, x;
	final double GRAVITY = 0.94;

	public HumanPaddle(int player) {
		upAccel = false;
		downAccel = false;
		y = 210;
		yVel = 0;
		if (player == 1) // first player
			x = 0;
		else if (player == 2)
			x = 680;
	}

	// public void colorChanger() {
	//
	//
	//
	// Color one = new Color(225,225,225);
	// Color two = new Color(112,112,122);
	// }
//HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIEEEEEEEEEEEEEEEEERRRRRRRRRRRRRRRRRRRRR IST DIE GRAPHICS METHODE DIE DIE DRAW GESCHICHTEN BETREIBT
	public void draw(Graphics g) {

		Color ownPurple = new Color(100, 0, 200);
		Color ownOrange = new Color(255, 165, 0);
		// g.setColor(ownPurple);
		g.setColor(Color.white);
		g.fillRect(x, (int) y, 20, 90);

		// g.fillOval(x, (int)y, 20, 80);

		// COLOUR CHANGER <---------------DER NAME ERKLÄRT ALLES

// DIE IF WERDE ICH NOCH VERFEINERN MÜSSEN ABER ERST MAL WILL ICH DASS ICH DIESEN BATZEN HIER IN NEM EIGENEN THREAD LAUFEN LASSEN KANN DENN DIE IF ABFRAGE WIRD SPÄTER EINE WHILE
		if (Pong.p1Score == 3) {

			{
				for (int i = 0; i < 80;) {

					{

						g.setColor(Color.red);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.green);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.red);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.green);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.red);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.green);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.red);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.green);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.yellow);
						g.fillRect(x, (int) y, 20, 90);

						g.setColor(Color.orange);
						g.fillRect(x, (int) y, 20, 90);

					}
				}
			}
		}
	}

	public void run() {
		
	}
	
	public void move() {
		if (upAccel) {
			yVel -= 2;

		} else if (downAccel) {
			yVel += 2;
		} else if (!upAccel && !downAccel) {
			yVel *= GRAVITY;
		}
		if (yVel >= 5) {
			yVel = 5;
		}

		else if (yVel <= -5)
			yVel = -5;

		y += yVel;

		if (y < 0)
			y = 0;

		if (y > 415)
			y = 415;

	}

	public void setUpAccel(boolean input) {
		upAccel = input;
	}

	public void setDownAccel(boolean input) {
		downAccel = input;
	}

	public float getY() {
		return (int) y;

	}

	public int getX() {
		return (int) x;
	}
}