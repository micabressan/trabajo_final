package com.kaluzny.web;

import com.kaluzny.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.*;

@RestController
@RequestMapping("api/main")
public class GameRestController {
    private GameRepository repository;

    @Inject
    public void setRepository(GameRepository repository) {
        this.repository = repository;
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<Game> addSlab(@RequestBody Game game) {

        Game currentGame = new Game();
        currentGame.setTitle(game.getTitle());
        currentGame.setDeveloper(game.getDeveloper());
        currentGame.setPrice(game.getPrice());

        return new ResponseEntity<>(repository.save(currentGame), HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.GET)
    public ResponseEntity<Collection<Game>> getAll() {
        return new ResponseEntity<>(repository.findAll(), HttpStatus.OK);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<Game> getSlabWithId(@PathVariable Long id) {
        return new ResponseEntity<>(repository.findOne(id), HttpStatus.OK);
    }

    @RequestMapping(params = {"title"}, method = RequestMethod.GET)
    public ResponseEntity<Collection<Game>> findBoardWithTitle(@RequestParam(value = "title") String title) {
        return new ResponseEntity<>(repository.findByTitle(title), HttpStatus.OK);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public ResponseEntity<?> updateSlabFromDb(@PathVariable("id") long id, @RequestBody ExtendedBoard extendedBoard){
        return null;
    }

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String welcomeToVisitor() {
        return "Hello! RequestMapping WORK !";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ResponseEntity<Game> deleteBookWithId(@RequestBody List<Long> ids) {
        for (Long id : ids) {
            repository.delete(id);
        }
        return new ResponseEntity<>(new Game(), HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.DELETE)
    public void deleteAllBooks() {
        repository.deleteAll();
    }
}