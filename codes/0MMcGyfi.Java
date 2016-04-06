package testBOUNCE;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;

@SuppressWarnings("serial")
public class ballPit extends JPanel {
	static boolean mouseClicked = false; 

	

	public class bPit extends Thread{
		public void run(){
			
			 class MousePressListener implements MouseListener{
				 
				 public void mousePressed(MouseEvent event)
				 {	 
//					 mouseClicked = true;
					 Ball ball = new Ball(ballPit.this);
					 int ballX = event.getX();
					 int ballY = event.getY();
					 Ball.setX(ballX);
					 Ball.setY(ballY);
					
					
				 }
				 		 
				public void mouseClicked(MouseEvent e) {}
				public void mouseEntered(MouseEvent e) {}
				public void mouseExited(MouseEvent e) {}
				public void mouseReleased(MouseEvent e) {}
				}
		
		}
	
	}
		

	 
	private void move() {
			Ball.move();
		}
	
	
	 
	@Override
	public void paint(Graphics g) {
		if(mouseClicked = true){
		super.paint(g);
		Graphics2D g2d = (Graphics2D) g;
		g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);
		Ball.paint(g2d);
		}
		
	}
	

	public static void main(String[] args) throws InterruptedException {
		
		System.out.println(mouseClicked);
		JFrame frame = new JFrame("Mini Tennis");
		ballPit game = new ballPit();
		frame.add(game);
		frame.setSize(300, 400);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);		
		//frame.addMouseListener(game.listener);	
		game.addMouseListener(game.listener);
		while(true) {
			game.move();
			game.repaint();
			Thread.sleep(10);
		}
	
	
}
}