import java.util.*;
import java.io.*;

public class HW01_5 {
	
	public static float getGPA(String line) {
		String[] parts = line.split(",");
		int totalGrades = 0;
		int size = parts.length;
		
		for (int i = 1; i < size; i++) 
			totalGrades += Integer.parseInt(parts[i]);
		
		return (float) totalGrades / (size - 1);
	}
	
	public static String csvToTsv(String line) {
		StringBuilder sb = new StringBuilder();
		String [] parts = line.split(",");
		
		for (String str : parts) 
			sb.append(str).append("\t");
		
		return sb.toString();
	}
	
	public static double[] getSubjectGPA(String line, double[] subjectMarks) {		
		ArrayList<String> marksList = new ArrayList<>(Arrays.asList(line.split(",")));
		marksList.remove(0); // Remove index.
		
		int subjPointer = 0;
		for (String mark : marksList) 
			subjectMarks[subjPointer++] += Integer.parseInt(mark);
		
		return subjectMarks;		
	}
	
	public static void fromToTxt(String from, String to) throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(from));
		PrintWriter pw = new PrintWriter(new FileWriter(to));
		String studentInfo = "";
		String basicInfo   = "";
		double [] subjectMarks;
		
		StringBuilder sb = new StringBuilder();
		
		basicInfo = br.readLine();	
		
		subjectMarks = new double[(basicInfo.split(",")).length - 1]; // number of subjects = whole line - index part.
		basicInfo = csvToTsv(basicInfo);		
		
		sb.append(basicInfo).append("Student GPA");
		sb.append(System.lineSeparator());
		
		int noOfStudents = 0;
		while ((studentInfo = br.readLine()) != null) { 
			sb.append(csvToTsv(studentInfo)).append(String.format("%.2f", getGPA(studentInfo)));
			sb.append(System.lineSeparator());
			subjectMarks = getSubjectGPA(studentInfo, subjectMarks);
			noOfStudents++;
		}
		
		sb.append(System.lineSeparator());
		
		sb.append("GPA").append("\t");
		
		for (double mark : subjectMarks) 
			sb.append(mark/noOfStudents).append("\t");		
		
		pw.write(sb.toString());
		
		br.close();
		pw.close();
		
	}
	
	public static void main(String[] args) throws IOException {
		Scanner in = new Scanner(System.in);
		String from = in.nextLine();
		String to   = in.nextLine();
		fromToTxt(from, to);
	}
}