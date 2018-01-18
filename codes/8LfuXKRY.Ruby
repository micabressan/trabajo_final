# Mastermind
# Build a Mastermind game (https://en.wikipedia.org/wiki/Mastermind_(board_game)
COLORS = {red: "\033[31m■\033[0m", green: "\033[32m■\033[0m",
           yellow: "\033[33m■\033[0m", blue: "\033[34m■\033[0m",
           magenta: "\033[35m■\033[0m", cyan: "\033[36m■\033[0m"}
module Colors
  def random_colors
    4.times.map {COLORS.to_a.sample}
  end

  def user_colors(user_pw)
    user_pw.select {|el| COLORS.keys.include?(el.to_sym)}.
                                map {|el| [el.to_sym, COLORS[el.to_sym]] }
  end
end

module Password
  include Colors
  def create
    if @choice == "creator"
      puts "Choose 4 of the following colors (separated by space): " \
            "red (#{COLORS[:red]}), green (#{COLORS[:green]}), " \
            "yellow (#{COLORS[:yellow]}), blue (#{COLORS[:blue]}), " \
            "magenta (#{COLORS[:magenta]}), cyan (#{COLORS[:cyan]})."
      user_pw = gets.chomp.split(" ")
      user_colors(user_pw)
    else
      random_colors()
    end
  end

  def decode(password, user_colors, pins, comp_colors)
    # Get colors code from array
    pw = password.map {|el| el[1]}
    usr_colors = user_colors.map { |row| row[1] }
    return true if pw == usr_colors
    # Arrays to control color indexes, to remove correct ones and to create a
    # copy of password array
    usr_idxs = [], rmv_idxs = [], temp_pw = []
    usr_colors.each_with_index do |val, i|
      if pw.include?(val)
        # Find if color is in the correct position:
        # 1- Add black color to pins array
        # 2- Add color index (correct ones) to be removed from temp_pw in
        # rmv_idxs array
        # 3- Add index and :black to comp_pins array (meaning computer is
        # guessing the colors)
        if pw[i] == val
          pins.push("\033[30m\033[47m■\033[0m")
          rmv_idxs.push(i)
          # keep correct colors and position (for computer guessing only)
          if @choice == "creator"
            comp_colors[i] = [:black, val]
          end
        else
          # if color is not in the correct position, add index to usr_idxs to be
          # compared later
          usr_idxs.push(i)
        end
      else
        comp_colors[i] = [:none, val]
      end
    end
    # Clone password array to change it
    pw.each { |val| temp_pw << val.dup }
    # Remove colors in the correct position from temp_pw array
    temp_pw.each_with_index { |val, i| temp_pw[i] = "" if rmv_idxs.include?(i) }
    usr_colors.each_with_index do |val, i|
      # Check if color should be compared again (possible white pins)
      if usr_idxs.include?(i)
        # Check if color exists to be compared, if so, add a white pin and delete
        # from temp array
        if temp_pw.include?(val)
          temp_pw.delete(val)
          pins.push("\033[37m■\033[0m")
          comp_colors[i] = [:white, val]
        else
          comp_colors[i] = [:none, val]
        end
      else
        next
      end
    end
    return false
  end
end

module Guess
  include Colors
  def computer(comp_colors)
    if comp_colors.empty?
      random_colors()
    else
      new_list = {}
      # Add black pinned colors to new_list array
      comp_colors.each { |k, v| new_list[k] = [v[0], v[1]] if v[0] == :black }
      # Generate new colors (excluding black/white positions)
      ids = comp_colors.select {|k, v| k if v[0] == :none}.keys
      gen_colors = ids.length.times.map {COLORS.to_a.sample}
      # Add colors in the wrong position to any other available one
      pos = comp_colors.select { |k, v| k if v[0] != :black }.keys
      comp_colors.map do |k, v|
        if v[0] == :white
          ind_list = pos.reject.with_index {|_el, i| i == k}
          sample = ind_list.sample
          new_list[sample] = [:white, v[1]]
          ind_list.delete(sample)
        end
      end
      # Get available positions
      free_pos = (0..3).select {|i| i unless new_list.keys.include?(i)}
      # Add them to new list
      gen_colors.each do |v|
        new_list[free_pos.last] = [nil, v[1]]
        free_pos.pop
      end
      # Create the new colors list
      new_colors = []
      new_list.sort.to_h.map { |k, v| new_colors.push([COLORS.key(v[1]), v[1]]) }
      new_colors
    end
  end

  def user(user_colors)
    puts "Choose 4 colors (separated by space): red (#{COLORS[:red]}), " \
          "green (#{COLORS[:green]}), yellow (#{COLORS[:yellow]}), " \
          "blue (#{COLORS[:blue]}), magenta (#{COLORS[:magenta]}), " \
          "cyan (#{COLORS[:cyan]})."
    color_list = gets.chomp.split(" ")
    color_list.each { |color| user_colors.push([color,COLORS[color.to_sym]]) \
                      if COLORS.has_key?(color.to_sym) }
    puts "Your guess ##{n}: #{user_colors.map {|el| el[1] }.join(" ")}"
  end
end

class Mastermind
  include Password, Guess
  def initialize(choice)
    @choice = choice
  end

  def start
    password = create()
    if @choice == "creator"
      puts "Done! Now the computer will try to guess the password.\n"
    else
      puts "Generating color sequence...\n"
      puts "Done! You have 10 turns to guess the sequence.\n"
    end
    guess(password)
  end

  private

  def guess(password)
    n = 1
    comp_colors = {}
    while n <= 10
      user_colors = []
      if @choice == "creator"
        # computer will try to guess the password
        color_list = computer(comp_colors)
        color_list.each { |color| user_colors.push([color[0], COLORS[color[0]].to_s]) \
                          if COLORS.has_key?(color[0]) }
        puts "Computer guess ##{n} is: #{user_colors.map {|el| el[1] }.join(" ")}"
      else
        # user will try to guess the password
        user(user_colors)
      end
      pins = []
      if decode(password, user_colors, pins, comp_colors)
        puts "Congratularions, you guessed the password: #{password.map {|el| \
                                                          el[1] }.join(" ")}"
        exit
      else
        if n == 10
          puts "Game over! Start a new game to play again."
          exit
        end
        puts "Try it again, here are the key pegs to help you: #{pins.shuffle. \
                                                                 join(" ")}"
      end
      n += 1
    end
  end
end
puts "Do you want to create the password of guess it? (Type 'creator' or 'guesser')"
choice = gets.chomp
new_game = Mastermind.new(choice)
new_game.start