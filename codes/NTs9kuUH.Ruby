#!/usr/local/bin/ruby -w

class Player
  attr_reader :hp, :offense, :defense, :initiative, :name

  def initialize(name, hp, offense, defense, initiative)
    @name = name
    @hp = hp
    @offense = offense
    @defense = defense
    @initiative = initiative
  end

  def attack(other)
    #Should we check for initiative here and decide who attacks first?
    other.hurt(@offense)
  end

  def hurt(how_much)
    @hp -= [0, how_much - @defense].max
  end

  def dead?()
    @hp <= 0
  end
end

class NameFactory
  def self.create_name
    ["Bodzio", "Agnieszka", "Druch", "Gonzo", "Beliar", "Antystenes", "Antyoksydant"].sample
  end
end

class PlayerFactory
  def create_player
  end
end


class StandardPlayerFactory < PlayerFactory
  def create_player
    # Player can have upto 9 defense points
    Player.new(NameFactory.create_name, 100, 10, Random.rand(10), 5)
  end
end

class TiePlayerFactory < PlayerFactory
  def create_player
    Player.new(NameFactory.create_name, 100, 10, 0, 0)
  end
end

class Game
  #Player1, player2?
  def run(player_factory)
    player1 = player_factory.create_player
    player2 = player_factory.create_player

    announce_players([player1, player2])

    while not (player1.dead? or player2.dead?)
      puts "Player1: #{player1.hp}, Player2: #{player2.hp}. FIGHT!"
      player1.attack(player2)
      player2.attack(player1)
    end

    puts "Here comes the end!"
    [player1, player2].each{ |player| if player.dead? then puts "#{player.name} died..." end }

    puts "GG!"
  end

  private
  def announce_player(player)
    puts "Player #{player.name}! With #{player.hp} hp, #{player.offense} attack and #{player.defense} defense!"
  end
  def announce_players(players)
    players.each{ |player| announce_player(player) }
  end
end