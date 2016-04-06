package testBOUNCE;

import java.awt.Graphics2D;

public class Ball {
	static int x;
	static int y;
	int xa = 1;
	int ya = 1;
	private ballPit game;

	public Ball(ballPit game) {
		this.game= game;
	}
	
	public static void setX(int mouseX){
		mouseX = x;		
	}
	
	public static void setY(int mouseY){
		mouseY = y;
	}
	
	
	void move() {
		if (x + xa < 0)
			xa = 1;
		if (x + xa > game.getWidth() - 30)
			xa = -1;
		if (y + ya < 0)
			ya = 1;
		if (y + ya > game.getHeight() - 30)
			ya = -1;

		x = x + xa;
		y = y + ya;
		}

	
	
	public void paint(Graphics2D g) {
		if(ballPit.mouseClicked = true){		
		g.fillOval(x, y, 30, 30);
		}
		
	}
}