 Schema::create('game_lists', function (Blueprint $table) {
            $table->increments('id');
            $table->text('title');
            $table->text('author');
            $table->text('description');
            $table->timestamps();
        });