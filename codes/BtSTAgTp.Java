package app.util;

import app.model.Game;
import org.springframework.http.*;
import org.springframework.http.HttpEntity;
import org.springframework.web.client.RestTemplate;

public class RestClient {

    private String server = "http://localhost:8080/api/main";
    private RestTemplate rest;
    private HttpHeaders headers;
    private Game game;

    public RestClient(Game game) {
        this.game = game;
        this.rest = new RestTemplate();
        this.headers = new HttpHeaders();
        headers.add("authorization","Basic dXNlcjp1c2Vy");
        headers.add("Accept", "application/json");
        headers.add("Content-Type", "application/json");
    }

    public void post() {
        HttpEntity<?> httpEntity = new HttpEntity<>(game,headers);
        ResponseEntity<Game> responseEntity = rest.exchange("http://localhost:8080/api/main",HttpMethod.POST,httpEntity,Game.class);
    }
}