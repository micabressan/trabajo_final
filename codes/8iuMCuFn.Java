import javax.swing.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import org.json.*;
import java.util.ArrayList;

class WeatherData {
    private double temperature;
    private double windSpeed;
    private String weatherDescription;

    public WeatherData( double temperature, double windSpeed, String weatherDescription) {
        this.temperature = temperature;
        this.windSpeed = windSpeed;
        this.weatherDescription = weatherDescription;
    }

    @Override
    public String toString() {
        return "Temperature: " + temperature + "\n Windspeed: " + windSpeed + "\n Description: " + weatherDescription;
    }
}

public class WeatherApp {

    public static void main( String args[] ) {

        HttpThread httpThread = new HttpThread();
        httpThread.setHttpThreadListener((jsonResponse) -> {
            JOptionPane.showMessageDialog( null, jsonResponse );
            System.out.println(jsonResponse);


        });
        new Thread( httpThread ).start();

        /* T4
        ArrayList<WeatherData> weatherDatas = new ArrayList<>();
        WeatherData monday = new WeatherData(2.5, 3.2, "Sunny");
        weatherDatas.add(monday);
        weatherDatas.add(new WeatherData(4.5, 2.3, "Cloudy"));

        for( WeatherData wd : weatherDatas) {
            System.out.println( wd );
        }

        ArrayList<String> viikonpaivat = new ArrayList<>();
        viikonpaivat.add("Monday");
        viikonpaivat.add("Tuesday");
        viikonpaivat.add("Wednesday");

        for ( String s : viikonpaivat ) {
            System.out.println( s );
        }*/
    }
}

interface HttpThreadListener {
    void jsonResponseReady ( String jsonResponse );
}

class HttpThread implements Runnable {
    private HttpThreadListener listener;
    private final String url = "http://api.openweathermap.org/data/2.5/forecast?q=Tampere&mode=json&appid=e32aebd66ffbb075ad8e4dabdf1a8309";

    public void setHttpThreadListener ( HttpThreadListener listener ) {
        this.listener = listener;
    }

    @Override
    public void run() {
        String jsonResponse = "";
        try {
            URL openWeatherMapUrl = new URL( url );
            BufferedReader in = new BufferedReader( new InputStreamReader( openWeatherMapUrl.openStream() ));
            String line;
            while ( (line = in.readLine()) != null ) {
                jsonResponse += line;
            }
            in.close();
            listener.jsonResponseReady( jsonResponse );
        }
        catch (MalformedURLException e) {
            System.out.println("Url exception");
        }
        catch (IOException e) {
            System.out.println("IO exception");
        }
    }
}