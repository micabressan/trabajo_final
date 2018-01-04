
class Ajastin extends Thread
{
	public int sekunnit;
	public int minuutit;
	public int tunnit;
	private int sleepTime;
	
	public void ajastin()
	{
		sekunnit = 0;
		minuutit = 0;
		tunnit = 0;
		sleepTime = 1000;
	}
	
	public void kello()
	{
		sekunnit++;
		if(sekunnit == 59)
		{
			minuutit++;
			sekunnit = 0;
			if(minuutit == 59)
			{
				tunnit++;
				minuutit = 0;
				if(tunnit == 23 && minuutit == 59 && sekunnit == 59)
				{
					sekunnit = 0;
					minuutit = 0;
					tunnit = 0;
				}
			}
		}
		System.out.println("Kello: " + tunnit + ":" + minuutit + ":" + sekunnit);
	}
	
	public void run() 
	{
		while(true)
		{
			kello();
            try {
                Thread.sleep( 1000 );
            } catch (InterruptedException ex) {
               System.out.println( ex );
            }
		}
    }
}



public class harj5
{
	public static void main(String[] args)
	{
		System.out.println( "Luodaan saikeet...");
        Ajastin ajastin = new Ajastin();
		ajastin.start();
	}
}