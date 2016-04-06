  private void draw() {
	// clear
        Gdx.gl.glClearColor(25/255f , 113/255f, 146/255f, 1f);  //background color
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);   //invisible textures are drawn?

	drawGame();
    }


   private void drawGame() {
   	_batch.begin();
        Color c = _batch.getColor();

        _batch.setColor(0, 0, 0, 0.5f);
        _batch.draw(_vignette, 0, 0, (float) _screenSize.x, (float) _screenSize.y);

        _batch.setColor(c);
        _ball.draw(_batch);
        _racket.draw(_batch);
        _blockMap.draw(_batch);
        _player.draw(_batch, _font, _screenSize);
        _dropManager.draw(_batch);
        _batch.end();
   }