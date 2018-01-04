 @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<?> addSlab(@RequestBody Game game) {

        Game currentGame = new Game();
        currentGame.setTitle(game.getTitle());
        currentGame.setDeveloper(game.getDeveloper());
        currentGame.setPrice(game.getPrice());

        return new ResponseEntity<>(repository.save(currentGame), HttpStatus.OK);
    }