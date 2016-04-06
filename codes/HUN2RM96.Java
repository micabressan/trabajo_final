//package sestta;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class HW01_5 {

	public static void main(String[] args) throws IOException {
		String dir = "rezultati.tsv";
		File f = new File(dir);
		BufferedReader bfr = new BufferedReader(new FileReader(f));

		String[] title = bfr.readLine().split("[\t]"); // get over the title!
		ArrayList<ArrayList<Integer>> grades = new ArrayList<>();
		String tmp;
		while ((tmp = bfr.readLine()) != null) {
			String[] tmpGrades = tmp.split("[\t]");
			grades.add(new ArrayList<Integer>());
			for (int i = 0; i < tmpGrades.length; i++)
				grades.get(grades.size() - 1).add(
						Integer.parseInt(tmpGrades[i]));
		}
		bfr.close();

		float[] averageGrade = new float[grades.get(0).size() - 1];
		for (int i = 0; i < grades.size(); i++) {
			float gpa = 0;
			for (int j = 1; j < grades.get(i).size(); j++) {
				gpa += grades.get(i).get(j);
				averageGrade[j - 1] += grades.get(i).get(j);
			}

			gpa = gpa / (grades.get(i).size() - 1);
			System.out.printf("Student with index %d has gpa of: %.2f\n",
					grades.get(i).get(0), gpa);

		}
		// System.out.println(grades);
		System.out.println("The average grades for the subjects are: ");
		for (int i = 0; i < averageGrade.length; i++)
			System.out.printf("%s: %.2f\n", title[i + 1], averageGrade[i]
					/ grades.size());
	}
}