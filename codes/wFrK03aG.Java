/*
 * Name:
 * Date:
 * Course Number:
 * Course Name:
 * Problem Number:
 * Email:
 * Short Description of the Problem
 */
 
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeMap;




public class WordCrossReference {
		
	
		// **********************************************
	private static void process(Scanner sc, String args[]) throws FileNotFoundException {
		
		String aliceString,commonWords ;
		int lineNumber ;
        TreeMap<String, LinkedHashSet<String>> map = new TreeMap<>();
        try {
        	ScannerWithLineno swl = new ScannerWithLineno(new File("alice30.txt"));
        	ScannerWithLineno swl1 = new ScannerWithLineno(new File("CommonWords.txt"));
        	System.out.println("Allow noise word? Y/N");
        	String input = new Scanner(System.in).next();

        
        	while(swl.hasNext()) {	
        		aliceString = swl.next();
        		commonWords = swl.next();
        		lineNumber = swl.getLineno();	
        		
        		if(!map.containsKey(aliceString)) {
        			map.put(aliceString, new LinkedHashSet<>());}
        		if(map.containsKey(commonWords)&&input.equalsIgnoreCase("y")) {
        			map.remove(commonWords);
        		}else {
        	
        		map.get(aliceString).add(String.valueOf(lineNumber));
        	}}
        	Set<String> keys = map.keySet();
            for(String key: keys){
                System.out.println(key + ": " + map.get(key));
            }swl.close();
        }catch(FileNotFoundException e) {
        	 e.printStackTrace();
        }
	}


    //**********************************************   
    private static boolean doThisAgain(Scanner sc, String prompt) {
        System.out.print(prompt);
        String doOver = sc.nextLine();
        return doOver.equalsIgnoreCase("Y");
    }
   
    //**********************************************  
    public static void main(String args[]) throws IOException {
        final String TITLE = "CSC220 Project WordCrossReference";
        final String CONTINUE_PROMPT = "Do this again? [y/N] ";
       
        System.out.println("Welcome to " + TITLE);
        Scanner sc = new Scanner(System.in);
        do {
            process(sc, args);
        } while (doThisAgain(sc, CONTINUE_PROMPT));
        sc.close();
        System.out.println("Thank you for using " + TITLE);
    }
 
}