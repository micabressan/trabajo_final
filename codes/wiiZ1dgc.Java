import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Scanner;
import javax.swing.*;

public class ButtonGrid implements ActionListener,Error
{
	static int x;
	int serve=0;
	JFrame frame=new JFrame();
	JButton[][] grid;
	int counter=1;
	public ButtonGrid(int width, int length)
	{
		int size=x*x;
		frame.setLayout(new GridLayout(width,length));
		grid=new JButton[width][length];
		for(int y=0; y<length; y++)
		{
			for(int x=0; x<width; x++)
			{
				final Turn t=new Turn();
				JButton yosi = new JButton();
				yosi.setFont(new Font("Arial", Font.PLAIN, 70));
				yosi.setText("");
				grid[x][y]=yosi;
				grid[x][y].setPreferredSize(new Dimension(180, 160));
				t.setX(x);
				t.setY(y);
				frame.add(grid[x][y]);
				grid[x][y].addActionListener(new ActionListener()
				{
					public void actionPerformed(ActionEvent e)
					{
						char player = 0;
						if(!grid[t.getX()][t.getY()].getText().equals(""));
						else
						{
							if(serve==0)
							{
								player='x';
								serve=1;
							}
							else
							{
								player='o';
								serve=0;
							}
							grid[t.getX()][t.getY()].setText(""+player);
						}
						didsomeonewinInCol();
						didsomeonewinInRow();
						didsomeonewinInMainDiagonal();
						didsomeonewinInSecDiagonal();
						if(counter==size)
						{
							JOptionPane.showMessageDialog(null, "No One Won", "InfoBox: " +"Draw", JOptionPane.INFORMATION_MESSAGE);
							System.exit(0);
						}
						counter++;
						
					}
				});
			}
		}

		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.pack();
		frame.setVisible(true);
	}
	
	void didsomeonewinInCol()
	{
		boolean isend=true;
		for(int i = 0 ; i < x ; i++)
		{
			for(int j = 0 ; j < x-1 ; j++)
			{
				if(!grid[i][j].getText().equals(grid[i][j+1].getText()) ||(grid[i][j].getText().equals("")))
				isend=false;
				}
				if(isend==true)
				{
				JOptionPane.showMessageDialog(null, "WON IN Col", "InfoBox: " +"WIN", JOptionPane.INFORMATION_MESSAGE);
				System.exit(0);
			}
			isend=true;
		}
		
	}

	void didsomeonewinInRow()
	{
		boolean isend=true;
		for(int j = 0 ; j < x ; j++)
		{
			for(int i = 0 ; i < x-1 ; i++)
			{
				if(!grid[i][j].getText().equals(grid[i+1][j].getText()) ||(grid[i][j].getText().equals("")))
				isend=false;
				}
				if(isend==true)
				{
				JOptionPane.showMessageDialog(null, "WON IN Row", "InfoBox: " +"WIN", JOptionPane.INFORMATION_MESSAGE);
				System.exit(0);
			}
			isend=true;
		}
	}

	void didsomeonewinInMainDiagonal()
	{
		boolean isend=true;
		for(int i = 0 ; i < x-1 ; i++)
		{
				if(!grid[i][i].getText().equals(grid[i+1][i+1].getText()) ||(grid[i][i].getText().equals("")))
				isend=false;
				}
				if(isend==true)
				{
				JOptionPane.showMessageDialog(null, "WON IN Main Diagonal", "InfoBox: " +"WIN", JOptionPane.INFORMATION_MESSAGE);
				System.exit(0);
		}
		isend=true;
	}
	
	void didsomeonewinInSecDiagonal()
	{
		boolean isend=true;
		for(int i = 0 ; i < x-1 ; i++)
		{
				if(!grid[i][x-1-i].getText().equals(grid[i+1][x-2-i].getText()) ||(grid[i][x-1-i].getText().equals("")))
				isend=false;
				}
				if(isend==true)
				{
				JOptionPane.showMessageDialog(null, "WON IN Sec Diagonal", "InfoBox: " +"WIN", JOptionPane.INFORMATION_MESSAGE);
				System.exit(0);
		}
		isend=true;
	}

	public static void main(String[] args)
	{
		Scanner sc = new Scanner(System.in);
		x=sc.nextInt();
		while(x<3||x>6)
		{
			System.out.println(printerror());
			x=sc.nextInt();
		}
		new ButtonGrid(x,x);
	}
	
	public void actionPerformed(ActionEvent e)
	{
	
	}
	public static String printerror() {
		return "please enter size between 3-6";
		
	}

}