package shit;

import java.io.FileReader;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class MapReader {
	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		JSONParser parser = new JSONParser();
		try {
			JSONObject jsonObject = (JSONObject) parser.parse(new FileReader(
					"assets/map.json"));

			JSONObject continents = (JSONObject) jsonObject.get("continents");
			JSONObject countries = (JSONObject) jsonObject.get("countries");

			Iterator<String> continentsItr = (Iterator<String>) continents
					.keySet().iterator();
			HashMap<String, Continent> continentsMap = new HashMap<String, Continent>();

			while (continentsItr.hasNext()) {
				String id = (String) continentsItr.next();
				JSONObject contents = (JSONObject) continents.get(id);
				String name = (String) contents.get("name");
				String bonus = (String) contents.get("bonus");
				String[] owns = convertJSONArray(contents.get("owns"));
				continentsMap.put(id, new Continent(id, name, bonus, owns));
			}

			Iterator<String> countriesItr = (Iterator<String>) countries
					.keySet().iterator();
			HashMap<String, Country> countriesMap = new HashMap<String, Country>();

			while (countriesItr.hasNext()) {
				String id = (String) countriesItr.next();
				JSONObject contents = (JSONObject) countries.get(id);
				String name = (String) contents.get("name");
				String[] rgb = convertJSONArray(contents.get("rgb"));
				String[] borders = convertJSONArray(contents.get("borders"));
				countriesMap.put(id, new Country(id, name, rgb, borders));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String[] convertJSONArray(Object jsonObj) {
		JSONArray jsnArr = (JSONArray) jsonObj;
		Object[] objArr = jsnArr.toArray();
		String[] stringArr = Arrays.asList(objArr).toArray(
				new String[objArr.length]);
		return stringArr;
	}

}