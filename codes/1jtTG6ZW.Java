//Import Scanner data type.
import java.util.Scanner;

//Main class
public class Main
{
	//Program starts here.
	public static void main(String[] args)
	{
		//Declare and initialize user input.
		Scanner scan = new Scanner(System.in);
		
		//Set program run to true.
		boolean run = true;
		
		//Have this program loop, as long as the user wants to continue converting measurements.
		while (run)
		{
			//Offer the user the options of measurement conversion.
			System.out.println("Convert:");
			System.out.println("1. Inches to Centimeters\t5. Centimeters to Inches");
			System.out.println("2. Feet to Centimeters\t\t6. Centimeters to Feet");
			System.out.println("3. Yards to Meters\t\t7. Meters to Yards");
			System.out.println("4. Miles to Kilometers\t\t8. Kilometers to Miles");
			
			//Get the user's choice of the options.
			System.out.print("\nEnter your choice:");
			int choice = scan.nextInt();
			
			//Ensure that the user's option choice is valid.
			while (choice < 1 || choice > 8)
			{
				System.out.print("Invalid input, please try again:");
				choice = scan.nextInt();
			}
			
			//Declare user's measurement variable.
			double num = 0; //User input.
			
			//Declare the answer variable, which will later recieve the result from the method chosen.
			double answer = 0;
			
			System.out.println("");
			
			//Use a switch-statement (or an if-statement) to run the correct code for the user's selection.
			switch (choice)
			{
				case 1:
					System.out.print("Enter your amount of inches:");
					num = scan.nextDouble();
					answer = inchesToCentimeters(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " inches = " + answer + " centimeters");
					break;
				case 2:
					System.out.print("Enter your amount of feet:");
					num = scan.nextDouble();
					answer = feetToCentimeters(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " feet = " + answer + " centimeters");
					break;
				case 3:
					System.out.print("Enter your amount of yards:");
					num = scan.nextDouble();
					answer = yardsToMeters(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " yards = " + answer + " meters");
					break;
				case 4:
					System.out.print("Enter your amount of miles:");
					num = scan.nextDouble();
					answer = milesToKilometers(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " miles = " + answer + " kilometers");
					break;
				case 5:
					System.out.print("Enter your amount of centimeters:");
					num = scan.nextDouble();
					answer = centimetersToInches(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " centimeters = " + answer + " inches");
					break;
				case 6:
					System.out.print("Enter your amount of centimeters:");
					num = scan.nextDouble();
					answer = centimetersToFeet(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " centimeters = " + answer + " feet");
					break;
				case 7:
					System.out.print("Enter your amount of meters:");
					num = scan.nextDouble();
					answer = metersToYards(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " meters = " + answer + " yards");
					break;
				case 8:
					System.out.print("Enter your amount of kilometers:");
					num = scan.nextDouble();
					answer = kilometersToMiles(num); //Method's returned output is stored in the answer variable.
					System.out.println(num + " kilometers = " + answer + " miles");
					break;
				default:
					//The user should not be able to get to here, since the earlier while-loop checks to see if the user inputted a number between 1 and 8.
					System.out.println("How did you bypass the while loop check? Impossible!");
					break;
			}// End of switch-statement for the user's selection.
			
			//Ask the user if they would like to continue the program.
			System.out.print("\nWould you like to convert another measurement? (Y or N):");
			
			//Get the first letter of their input.
			char runChar = scan.next().charAt(0);
			
			//If input starts with a y, then continue the program. Otherwise, end the program.
			if (runChar == 'Y' || runChar == 'y')
			{
				run = true;
				System.out.println("");
			}
			else
			{
				run = false; //Setting the run variable to false will end the first while-loop.
				System.out.println("Thank you, goodbye!");
			}
		} //End of while-loop to repeat the program.
	} //End of main method.
	
	//Conversion methods
	public static double inchesToCentimeters(double n) // 1
	{
		return n * 2.54;
	}
	public static double feetToCentimeters(double n) // 2
	{
		return n * 30.48;
	}
	public static double yardsToMeters(double n) // 3
	{
		return n * 0.9144;
	}
	public static double milesToKilometers(double n) // 4
	{
		return n * 1.609344;
	}
	public static double centimetersToInches(double n) // 5
	{
		return n / 2.54;
	}
	public static double centimetersToFeet(double n) // 6
	{
		return n / 30.48;
	}
	public static double metersToYards(double n) // 7
	{
		return n / 0.9144;
	}
	public static double kilometersToMiles(double n) // 8
	{
		return n / 1.609344;
	}
	
}//End of class Main.