package lbalzs.soft.moviedb;

import android.os.AsyncTask;
import android.util.Log;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;


public class SynchFromWeb extends AsyncTask{

    private String userName;
    private MovieAdapter adapter;
    private List<MovieItem> moviesTemp = new ArrayList<>();

    public SynchFromWeb(String username, MovieAdapter adapterpassed){
        this.userName = username;
        this.adapter = adapterpassed;
    }

    @Override
    protected Object doInBackground(Object[] objects) {
        try{

            String link = "http://users.atw.hu/moviedb/getmoviesforuser.php?user="+userName;
            URL url = new URL(link);
            HttpClient client = new DefaultHttpClient();
            HttpGet request = new HttpGet();
            request.setURI(new URI(link));
            HttpResponse response = client.execute(request);
            BufferedReader in = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
            StringBuffer sb = new StringBuffer("");
            String line = "";
            if ((line = in.readLine()) != null){

                String[] moviesplit = line.split("<br>");

                for(int i = 0; i < moviesplit.length; i++){
                    Log.d("GOTTHIS", moviesplit[i]);
                    String[] split = moviesplit[i].split(";");

                    MovieItem temp = new MovieItem();
                    temp.title = split[0];
                    temp.category = split[1];
                    temp.description = split[2];
                    temp.releaseYear = Integer.parseInt(split[3]);
                    temp.agelimit = split[4];
                    temp.genre = split[5];
                    temp.length = Integer.parseInt(split[6]);
                    temp.coverURL = split[7];

                    moviesTemp.add(temp);
                }

            }
            in.close();


        } catch(Exception e){
            return new String("fail");
        }
        return"done";
    }

    @Override
    protected void onPostExecute(Object o){
        Log.d("SIZEOFSHIT", Integer.toString(moviesTemp.size()));
        for (MovieItem mi : moviesTemp){
            mi.save();
        }
    }
}