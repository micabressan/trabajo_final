package CinemaBookingSystem;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class CinemaSystem {

	//Strings to hold user keyboard input and current selected movie.
	public static String movieChoice = "";
	public static String userInput = "";
	public static Scanner in = new Scanner(System.in);
	//Booleans used for loops based on whether the user has chosen a movie/time yet.
	public static boolean movieChosen = false;
	public static boolean timeChosen = false;
	//SimpleDateFormats to switch between 24 hour and 12 hour time.
	public static SimpleDateFormat displayFormat = new SimpleDateFormat("HH:mm");
	public static SimpleDateFormat parseFormat = new SimpleDateFormat("hh:mm a");
	//Public int to store the theater for use in other classes.
	public static int theaterNum = 0;
	public static Date chosenTime;
	//Line break string.
	public static final String lb = "----------------------------------------";

	//The main method calls all the methods throughout the program.
	public static void main(String[] args) throws ParseException {
		//Set up the theater and show hash maps, then prompt the user to find a movie.
		Theater.createTheaters();
		Show.addMovies();
		System.out.println("Welcome to CinemaBooking 2.0!");
		System.out.println(lb);
		//Method for the user to search through the movies.
		findMovie();
		System.out.println(lb);
		//Once the user finds a movie they verify it and choose the theater.
		chooseTheater();
		System.out.println(lb);
		//User chooses a time to see the movie.
		while (!timeChosen) {
			chooseTime();
		}
		System.out.println(lb);
		//Find out how many adult/child seats and choose the rows/seats.
		SeatBooking.reserveSeats(theaterNum);
		System.out.println(lb);
		//Get the users name and phone number, and generate an ID.
		Customer.getCustomerInfo();
		System.out.println(lb);
		//Finally print out the "stub" with all the information on it,
		Customer.printFinalInfo();
		System.out.println(lb);
	}

	//This method uses a while loop to let the user choose how to find a movie, either show a list, search by name, or search by time.
	//It also uses the movieChosen boolean to decide when to move on to seat reservations.
	public static void findMovie() throws ParseException {

		//Let the user search for a movie 1 of 3 ways, this continues until they type "done".
		while (!movieChosen) {
			System.out.println("Type 1 to see a list of movies that are currently playing, type 2 to search for a movie by name, type 3 to search for movies playing at a certain time.");
			System.out.print("Once you have found the movie you would like to see, type 'done' to procede to seat reservations: ");
			userInput = in.nextLine();
			if (userInput.equals("1")) {
				System.out.println("");
				Show.listMovies();
				System.out.println("");
			}
			else if (userInput.equals("2")) {
				System.out.print("\nWhat movie would you like to search for?: ");
				userInput = in.nextLine();
				if (Show.isMovie(userInput))
					System.out.println("Movie found!\n");
				else 
					System.out.println("Movie not found, please try again.\n");
			}
			//If the user wants to search via time, it must be converted from 12 hour to 24 hour so it can be compared to the array.
			//For this I use SimpleDateFormat and parseInt.
			else if (userInput.equals("3")) {
				System.out.print("\nWhat time would you like to search for? (Use the format hh:mm am/pm): ");
				userInput = in.nextLine();
				Date formatTime;
				try {
					formatTime = parseFormat.parse(userInput);
					String formatTimeString = displayFormat.format(formatTime).toString();
					formatTimeString = formatTimeString.replaceAll("[^0-9]", "");
					int timeToSearch = Integer.parseInt(formatTimeString);
					Show.searchTimes(timeToSearch);
				} catch (Exception e) {
					System.out.println("\nPlease enter a time in the format hh:mm am/pm\n");
				}
			}
			else if (userInput.equalsIgnoreCase("done")) {
				movieChosen = true;
			}
			else {
				System.out.println("Invalid choice, please try again.");
			}
		}
	}

	//Verify what movie they want to see.
	//This way they can search for multiple movies before actually choosing one.
	public static void chooseTheater() {

		boolean theaterChosen = false;

		while (!theaterChosen) {
			System.out.print("Type the name of the movie you are reserving seats for: ");
			userInput = in.nextLine();
			theaterNum = Show.findTheaterNum(userInput);
			//Print what theater the movie is in and the format.
			Theater.returnTheaterInfo(theaterNum);
			if (theaterNum > 0)
				theaterChosen = true;
		}
	}

	//Let the user choose what time to see that movie.
	public static void chooseTime() {
		//Print the times for the chosen movie.
		Show.showTimes(theaterNum);
		System.out.print("\nWhich time would you like to reserve seats for?: ");
		userInput = in.nextLine();
		//Try/catch block to prevent format exception in the input.
		try {
			chosenTime = parseFormat.parse(userInput);
			System.out.println(lb);
			System.out.println("Your chosen time is: " + parseFormat.format(chosenTime));
			timeChosen = true;
		} catch (Exception e) {
			System.out.println("\nPlease enter a time in the format hh:mm am/pm\n");
		}
	}
}