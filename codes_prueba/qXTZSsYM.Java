package testjava;
import java.util.Timer;
import java.util.TimerTask;
public class Cat {
	
	//Fields and constants declaration
	Timer timer1;
	Timer timer2;
	protected String Name;
	protected String Color;
	protected String Sex;
	public double ResultWalk = 0;
	public double ResultRun = 0;
	protected boolean WalkIndicator = false;
	protected boolean RunIndicator = false;
	protected final double WALK_PER_SECOND = 0.12;  
	protected final double RUN_PER_SECOND = 1;
	protected long walkSeconds;
	protected long runSeconds;
	
	//Constructors
	public Cat() {
		this.Name = "";
		this.Color = "";
		this.Sex = "";
	}
	public Cat(String name, String color, String sex) {
		this.Name = name;
		this.Color = color;
		this.Sex = sex;
	}
	
	//Set values
	public void setName(String name){
		this.Name = name;
	}
	public void setColor(String color) {
		this.Color = color;
	}
	public void setSex(String sex) {
		this.Sex = sex;
	}
	
	//Get values
	public String getName() {
		return this.Name;		
	}
	public String getColor() {
		return this.Color;
	}
	public String getSex() {
		return this.Sex;
	}
	
	//Print all values at once
	public void CatInfo() {
		if(this.Name != "" && this.Color != "" && this.Sex != "") {
		System.out.println("Name: " + this.Name);
		System.out.println("Color: " + this.Color);
		System.out.println("Sex: " + this.Sex);
		} else {
			System.out.println("The cat atributes are not defined");
		}
	}
	
	//Cat actions
	public void Speak() {
		System.out.println("Meow!"); //Only thing that cat can say
	}
	
	public void Walk(long seconds) {
		walkSeconds = seconds;
		WalkIndicator = true;
		if(RunIndicator == true) {
			try {
				Thread.sleep(runSeconds*1000);
			} catch(InterruptedException ex) {
				Thread.currentThread().interrupt();
			}
		} else if(WalkIndicator == true) {
			try {
				Thread.sleep(walkSeconds*1000);
			} catch(InterruptedException ex) {
				Thread.currentThread().interrupt();
			}
		}
		timer1 = new Timer();
		timer1.schedule(new catWalk(), seconds*1000);
		this.ResultWalk += seconds * WALK_PER_SECOND;
	}
	
	public void Run(long seconds) {		
		runSeconds = seconds;
		RunIndicator = true;
		if(WalkIndicator == true) {
			try {
				Thread.sleep(walkSeconds*1000);
			} catch(InterruptedException ex) {
				Thread.currentThread().interrupt();
			}
		} else if(RunIndicator == true) {
			try {
				Thread.sleep(runSeconds*1000);
			} catch(InterruptedException ex) {
				Thread.currentThread().interrupt();
			}
		}
		timer2 = new Timer();
		timer2.schedule(new catRun(), seconds*1000);
		this.ResultRun += seconds * RUN_PER_SECOND;
	}
	
	public void RunAndWalk() {
		double FinalResult =  ResultWalk + ResultRun;
		if(RunIndicator == true || WalkIndicator == true) {
			try {
				Thread.sleep((walkSeconds+runSeconds)*1000);
				System.out.println("Total meters passed by walking and running : " + FinalResult);
			} catch(InterruptedException ex) {
				Thread.currentThread().interrupt();
			}
		} else {
			System.out.println("Cat has neither walked nor run");
		}
	}
	
	class catWalk extends TimerTask {
		public void run() {
			System.out.println("The cat started walking.");
			timer1.cancel();
			System.out.println("Cat has finished the walk. Total meters passed by walking: " + ResultWalk);
		}
	}
	
	class catRun extends TimerTask {
		public void run() {
			System.out.println("The cat started running.");
			timer2.cancel();
			System.out.println("Cat has finished the run. Total meters passed by running: " + ResultRun);
		}
	}
}