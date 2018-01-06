#!/usr/local/bin/ruby -w

class Actions
  class << self
    def attack_action
      :attack
    end
    def dead_action
      :dead
    end
  end
end

class Player
  attr_reader :hp, :offense, :defense, :initiative, :name

  def initialize(name, hp, offense, defense, initiative)
    @name = name
    @hp = hp
    @offense = offense
    @defense = defense
    @initiative = initiative
    @observers = []
  end

  def attack(other)
    #Should we check for initiative here and decide who attacks first?
    other.hurt(@offense)
    notify(Actions.attack_action)
  end

  def hurt(how_much)
    @hp -= [0, how_much - @defense].max
  end

  def dead?()
    result = @hp <= 0
    if result
      notify(Actions.dead_action)
    end
    return result
  end

  #"Subject" part:

  def attach(observer)
    unless @observers.include? observer
      @observers << observer
    end
  end

  def detach(observer)
    @observers.delete(observer)
  end

  def notify(action)
    @observers.each{ |observer| observer.update(self, action)}
  end

  #Design question: Should we inherit some Subject class?
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

    #todo: DI :)
    system = AchievementSystem.new
    system.add_achievement(Achievement.new("Sudden Death", "Die with your enemy", BothDeadCommand.new))
    system.add_achievement(Achievement.new("Fighter", "Attack at least once", FighterCommand.new))

    player1.attach(system)
    player2.attach(system)

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

class BothDeadCommand
  def initialize()
    @dead = []
  end

  def run(player, action)
    if action == Actions.dead_action
      puts "Checking if dead!"
      if @dead.include? player
        @dead = [player]
      else
        @dead << player
        if @dead.length == 2
          return @dead
        end
      end
      return false
    end
  end
end

class FighterCommand
  def run(player, action)
    if action == Actions.attack_action
      [player]
    else
      false
    end
  end
end

class Achievement
  attr_reader :name, :description, :check
  def initialize(name, desc, check)
    @name = name
    @description = desc
    @check = check
  end
end

class AchievementElement
  attr_reader :achievement
  attr_accessor :done_by
  def initialize(achievement)
    @achievement = achievement
    @done_by = []
  end
  def test(player, action)
    unless done_by.include? player
      result = achievement.check.run(player, action)
      if result
        result.each do |player|
          puts "#{player.name} earned #{achievement.name}: #{achievement.description}"
          done_by << player
        end
      end
    end
  end
end

#Todo: Flyweight
class AchievementSystem
  def initialize
    @achievements = []
  end

  def update(player, action)
    @achievements.each do |element|
      element.test(player, action)
    end
  end

  def add_achievement(achievement)
    @achievements << AchievementElement.new(achievement)
  end
end

Game.new.run(TiePlayerFactory.new)