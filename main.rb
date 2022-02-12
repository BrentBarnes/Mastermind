require_relative 'display.rb'
require_relative 'game.rb'
require_relative 'computer.rb'
require_relative 'player.rb'

def play_game
game = Game.new(Player.new, Computer.new)
game.play
repeat_game
end

def repeat_game
  puts "Would you like to play a new game? Press 'y' for yes or 'n' for no."
  repeat_input = gets.chomp
  if repeat_input == 'y'
    play_game
  else
    puts 'Thanks for playing!'
  end
end

# play_game