@Immutable
class Player {
    String name
    int reaction
}

class Bomb {
    int ticks

    static Bomb start() {
        new Bomb(ticks: 10 + new Random().nextInt(90))
    }

    Bomb skipToLastLoop(int loopReaction) {
        ticks = ticks % loopReaction
        this
    }

    Bomb waitTicks(int ticks) {
        this.ticks-= ticks
        this
    }

    boolean isExploded() {
        ticks <= 0
    }
}

class Game {
    List<Player> players

    Player findLooser() {
        def bomb = Bomb.start().skipToLastLoop(loopReaction)
        players.find { bomb.waitTicks(it.reaction).exploded }
    }

    private getLoopReaction() {
        players.sum { it.reaction }
    }
}

class ScoreBook {
    // Person -> How many looses
    Map<String, Integer> looses

    static ScoreBook forPlayers(List<Player> players) {
        new ScoreBook(looses: players.collectEntries { [it.name, 0] })
    }

    def playerExploded(Player player) {
        looses.compute(player.name, { name, looses -> looses + 1 })
    }
}

class GameSet {
    def playSets(int rounds, List<Player> players) {
        def scoreBook = ScoreBook.forPlayers(players)
        def game = new Game(players: players)
        [0..rounds].each { scoreBook.playerExploded(game.findLooser()) }
        scoreBook.looses
    }
}