package url;

import java.net.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.io.*;

public class URLReader {
	private static SimpleDateFormat trueFormat = new SimpleDateFormat(
			"yyyy-MM-dd");
	private static String[] factions = { "Игнесс", "Раанор", "Тарбис",
			"Витарра", "Дримнир" };

	public static void main(String[] args) throws Exception {

		Calendar firstDate = new GregorianCalendar(2005, 7, 8);
		Calendar lastDate = new GregorianCalendar(2015, 7, 17);
		Calendar currentDate = new GregorianCalendar();

		boolean levelUP = false;
		boolean clanAdoption = false;
		boolean statusChange = true;
		boolean clanExclusion = false;
		boolean proclivityAdoption = false;
		Boolean[] switchers = { levelUP, clanAdoption, statusChange,
				clanExclusion, proclivityAdoption };
		String name = "Play 4fun";

		while (!firstDate.after(lastDate) && !firstDate.after(currentDate)) {
			printEvents(firstDate, name, switchers);
			firstDate.add(Calendar.DAY_OF_YEAR, 1);
		}
	}

	/**
	 * returns URL http://gapi.ereality.ru/events/YYYY-MM-DD.txt where
	 * "YYYY-MM-DD" bases on search date
	 * 
	 * @param calendar
	 * @return
	 * @throws MalformedURLException
	 */
	private static URL buildURL(Calendar calendar) throws MalformedURLException {
		StringBuilder builder = new StringBuilder();
		builder.append("http://gapi.ereality.ru/events/");
		builder.append(trueFormat.format(calendar.getTime()));
		builder.append(".txt");
		return new URL(builder.toString());
	}

	/**
	 * prints events info page
	 * 
	 * @param calendar
	 * @throws MalformedURLException
	 * @throws IOException
	 */
	private static void printEvents(Calendar calendar, String name,
			Boolean[] bArray) {
		BufferedReader in;
		try {
			in = new BufferedReader(new InputStreamReader(buildURL(calendar)
					.openStream()));

			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				String[] event = inputLine.split("\\|");
				if (event[3].equals(name)) {
					buildString(event, calendar, bArray);
				}
			}
			in.close();
		} catch (MalformedURLException e) {
			System.out.println("URL formed not correct!");
		} catch (IOException c) {
			System.out
					.println("Incorrect event date or, no access to http://gapi.ereality.ru/");
			calendar.add(Calendar.DAY_OF_YEAR, 1);
		}
	}

	/**
	 * returns prepared to console output String
	 * 
	 * @param array
	 * @param calendar
	 * @param bArray
	 */
	private static void buildString(String[] array, Calendar calendar,
			Boolean[] bArray) {
		StringBuilder builder = new StringBuilder();
		builder.append(trueFormat.format(calendar.getTime()));
		builder.append(" ");
		builder.append(array[0]);
		builder.append(" ");
		builder.append(array[3]);
		subBuild(array[4], builder);
		switch (array[1]) {
		case "1":
			if (bArray[0]) {
				builder.append("Получение уровня ");
				subBuild(array[array.length - 1], builder);
				System.out.println(builder.toString());
			}
			break;
		case "2":
			if (bArray[1]) {
				builder.append("Принятие в клан ");
				subBuild(array[10], builder);
				subBuild(array[array.length - 1], builder);
				System.out.println(builder.toString());
			}
			break;
		case "3":
			if (bArray[2]) {
				subBuild(array[10], builder);
				subBuild(array[11], builder);
				builder.append("Смена статуса в клане ");
				subBuild(array[array.length - 1], builder);
				System.out.println(builder.toString());
			}
			break;
		case "4":
			if (bArray[3]) {
				builder.append("Исключение из клана");
				System.out.println(builder.toString());
			}
			break;
		case "5":
			if (bArray[4]) {
				builder.append("Принятие склонности ");
				subBuild(getFaction(array[array.length - 1]), builder);
				System.out.println(builder.toString());
			}
		}
	}

	/**
	 * concludes inputed Strong to brackets
	 * 
	 * @param string
	 * @param builder
	 */
	private static void subBuild(String string, StringBuilder builder) {
		builder.append("[");
		builder.append(string);
		builder.append("] ");
	}

	/**
	 * returns String with faction where character(String name) in
	 * 
	 * @param string
	 * @return
	 */
	private static String getFaction(String string) {
		String faction = "Нейтрал";
		switch (string) {
		case "2":
			faction = factions[0];
			break;
		case "3":
			faction = factions[1];
			break;
		case "4":
			faction = factions[2];
			break;
		case "5":
			faction = factions[3];
			break;
		case "6":
			faction = factions[4];
		}
		return faction;
	}
}