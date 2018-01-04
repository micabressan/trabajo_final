/*
Paul Hawkins
11/27/2017
This program generates a detailed summary of over 100 hurricanes.
It compiles it into neatly formatted data.
 */
import java.util.Scanner;
import java.io.PrintWriter;
import java.io.File;
import java.io.IOException;
public class HurricaneSelector {
    public static void main(String[] args) throws IOException{
        File readThis = new File("hurricanedata.txt");
        File writeTo = new File("summary.txt");
        PrintWriter writeFile = new PrintWriter(writeTo);
        Scanner readFiles = new Scanner(readThis);
        Scanner userIn = new Scanner(System.in);
        Scanner userInt = new Scanner(System.in);
        int countLines = 0;
        while(readFiles.hasNext()){
            readFiles.next();
            countLines++;
        }
        Scanner readAndWeep = new Scanner(readThis);
        countLines = countLines / 5;
        int[] theDates = new int[countLines];
        String[] theMonths = new String[countLines];
        double[] theWindSpeed =  new double[countLines];
        int theCategory[] = new int[countLines];
        int[] thePressure = new int[countLines];
        String theNames[] = new String[countLines];
        int theTotalPressure = 0;
        double theTotalWindspeed = 0;
        for (int i = 0; i < countLines; i++){
            theDates[i] = Integer.parseInt(readAndWeep.next());
            theMonths[i] = readAndWeep.next();
            thePressure[i] = Integer.parseInt(readAndWeep.next());
            theTotalPressure += thePressure[i];
            theWindSpeed[i] = Double.parseDouble(readAndWeep.next());
            theTotalWindspeed += theWindSpeed[i];
            theNames[i] = readAndWeep.next();
        }
        int minDate = Integer.MAX_VALUE;
        int maxDate = Integer.MIN_VALUE; //gets the year range, and then asks the user for a range of years in between this range.
        for (int date:theDates) {
            if (date < minDate) {
                minDate = date;
            }
            if (date > maxDate) {
                maxDate = date;
            }
        }
        boolean isChosen = false;
        int minYear = 0;
        int maxYear = 0;
        while(!isChosen) {
            System.out.println("Please provide a range of years between " + minDate + " and " + maxDate);
            System.out.println("What is your minimum year: ");
            minYear = userInt.nextInt();
            System.out.println("What is your maximum year: ");
            maxYear = userInt.nextInt();
            if(minYear < minDate || maxYear > maxDate){
                System.out.println("Please enter a new range, this is incorrect.");
            }else{

                isChosen = true;
            }
        }
        int numberOfYears = (maxYear - minYear) + 1;
        int countMin = minYear;
        int countMax = maxYear;
        int countThis = 0;
        int[] listOfDates = new int[numberOfYears];
        while(countMin <= countMax){ //creates a list of dates within that range.
            listOfDates[countThis] = countMin;
            countThis++;
            countMin++;
        }
        int[] dates = new int[countLines];
        String[] months = new String[countLines];
        double[] windSpeed =  new double[countLines];
        int category[] = new int[countLines];
        int[] pressure = new int[countLines];
        String names[] = new String[countLines];
        int totalPressure = 0;
        int total = 0;
        double totalWindspeed = 0;
        Scanner read = new Scanner(readThis);
        for (int i = 0; i < countLines; i++){ //generates all of the hurricanes between that range
            boolean inRange = false;
            int theDate = Integer.parseInt(read.next());
            for (int date: listOfDates ){
                if(theDate == date){
                    dates[i] = date;
                    total++;
                    inRange = true;
                }
            }
            if (inRange == true) {
                months[i] = read.next();
                pressure[i] = Integer.parseInt(read.next());
                totalPressure += pressure[i];
                windSpeed[i] = Double.parseDouble(read.next());
                totalWindspeed += windSpeed[i];
                names[i] = read.next();
            }else{
                read.next();
                read.next();
                read.next();
                read.next();
            }
        }

        for (int i = 0; i < windSpeed.length; i++){
            windSpeed[i] = windSpeed[i] * 1.15078;
        } //converts from knots to mph
        for (int i = 0; i < windSpeed.length; i++){ //calculates the category of the storm
            if(windSpeed[i] >= 74 && windSpeed[i] <= 95){
                category[i] = 1;
            }
            else if(windSpeed[i] >= 96 && windSpeed[i] <= 110){
                category[i] = 2;
            }
            else if(windSpeed[i] >= 111 && windSpeed[i] <= 129){
                category[i] = 3;
            }
            else if(windSpeed[i] >= 130 && windSpeed[i] <= 156){
                category[i] = 4;
            }else if(windSpeed[i] != 0.00){
                category[i] = 5;
            }else{
                category[i] = 0;
            }
        }
        int catMin = Integer.MAX_VALUE;
        int catMax = Integer.MIN_VALUE;
        for(int categoryNum : category){
            if (categoryNum < catMin && categoryNum != 0 ){
                catMin = categoryNum;
            }
            if (categoryNum > catMax && categoryNum != 0){
                catMax = categoryNum;
            }
        } //calculates the min and max category
        int presMin = Integer.MAX_VALUE;
        int presMax = Integer.MIN_VALUE;
        for (int pressureNum : pressure){
            if (pressureNum < presMin && pressureNum != 0){
                presMin = pressureNum;
            }
            if (pressureNum > presMax && pressureNum != 0){
                presMax = pressureNum;
            }
        } //calculates the min and max pressure
        double windMax = Double.MIN_VALUE;
        double windMin = Double.MAX_VALUE;
        for (double windSpeedNum : windSpeed){
            if (windSpeedNum < windMin && windSpeedNum != 0.00){
                windMin = windSpeedNum;
            }
            if(windSpeedNum > windMax && windSpeedNum != 0.00){
                windMax = windSpeedNum;
            }
        } //calculates the min and max wind speed
        int countCat1 = 0;
        int countCat2 = 0;
        int countCat3 = 0;
        int countCat4 = 0;
        int countCat5 = 0;
        int totalCats = 0;
        for (int cat: category) {
            totalCats += cat;
            if(cat == 1){
                countCat1++;
            }
            if (cat == 2){
                countCat2++;
            }
            if (cat == 3){
                countCat3++;
            }
            if (cat == 4){
                countCat4++;
            }
            if (cat == 5){
                countCat5++;
            }
        } //calculates the total number of cat entries.
        double averagePressure = totalPressure/(double)total; //calculates average pressure
        double averageCat = totalCats/(double)total; //calculates average cat
        double averageWindspeed = totalWindspeed/(double)total; //calculates average WS
        System.out.printf("%42s\n" , ("Hurricanes " + minDate + " - " + maxDate));
        System.out.printf("%-7s %-12s %-11s %-16s %-19s\n", "Year", "Hurricane", "Category", "Pressure (mb)", "Wind Speed (mph)"); //prints out results, formatted neatly
        System.out.print("====================================================================\n");
        int countIt = 0;
        while(countIt < countLines){
            if (dates[countIt] != 0) {
                System.out.printf("%-8d %-14s %-9d %-17d %6.2f\n", dates[countIt], names[countIt], category[countIt], pressure[countIt], windSpeed[countIt]);
                countIt++;
            }else{
                countIt++;
            }
        }

        System.out.print("====================================================================\n");
        System.out.printf("      %-17s %-9.1f %-15.1f %8.2f\n","Average:", averageCat, averagePressure, averageWindspeed);
        System.out.printf("      %-17s %-9d %-15d %8.2f\n","Minimum:", catMin, presMin, windMin);
        System.out.printf("      %-17s %-9d %-15d %8.2f\n\n","Maximum:", catMax, presMax, windMax);
        System.out.println("Summary of Categories: ");
        System.out.printf("   %-4s %2d\n","Cat 1:",countCat1);
        System.out.printf("   %-4s %2d\n","Cat 2:",countCat2);
        System.out.printf("   %-4s %2d\n","Cat 3:",countCat3);
        System.out.printf("   %-4s %2d\n","Cat 4:",countCat4);
        System.out.printf("   %-4s %2d\n","Cat 5:",countCat5);
        //start file writing
        writeFile.printf("%-7s %-12s %-11s %-16s %-19s\n", "    ", "         ", "Category", "Pressure (mb)", "Wind Speed (mph)");
        writeFile.print("====================================================================\n");

        writeFile.printf("      %-17s %-9.1f %-15.1f %8.2f\n","Average:", averageCat, averagePressure, averageWindspeed);
        writeFile.printf("      %-17s %-9d %-15d %8.2f\n","Minimum:", catMin, presMin, windMin);
        writeFile.printf("      %-17s %-9d %-15d %8.2f\n\n","Maximum:", catMax, presMax, windMax);
        writeFile.println("Summary of Categories: ");
        writeFile.printf("   %-4s %2d\n","Cat 1:",countCat1);
        writeFile.printf("   %-4s %2d\n","Cat 2:",countCat2);
        writeFile.printf("   %-4s %2d\n","Cat 3:",countCat3);
        writeFile.printf("   %-4s %2d\n","Cat 4:",countCat4);
        writeFile.printf("   %-4s %2d\n","Cat 5:",countCat5);
        writeFile.close();










    }
}