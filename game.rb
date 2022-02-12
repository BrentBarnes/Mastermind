require_relative 'player.rb'
require_relative 'computer.rb'

class Game
  include Display
  
  attr_accessor :turn, :player, :computer, :game_over, :computer_guess, :clue_count, :guess_index, :all_clues, :cc_index

  def initialize(player, computer)
    @player = player
    @computer = computer
    @turn = 12
    @game_over = false
    @computer_guess = 2
    @guess_index = 0
    @cc_index = 0
    @clue_count = 0
    @all_clues = []
  end

  def play
    rules
    input = gets.chomp
    if input == '1'
      puts "If ran"
      until game_over == true do
        breaker_round
      end
    elsif input == '2'
      puts "Elsif ran"
      player.set_player_code
      until game_over == true do
        maker_round
      end
      puts "game over: #{game_over}"
    else
      puts "Else ran"
      puts 'Please enter \'1\' or \'2\''
      get_player_input
    end
  end

private

  def get_player_input
    gets.chomp
  end

  def new_turn
    puts "Type in a 4 numbered guess (1-6). Turns remaining: #{turn}."
    @turn -= 1
  end

  def matches_to_nil(guesser)
    matches = guesser.each_index.select{|i| guesser[i] == (computer_guess - 1).to_s}
    puts "matches length: #{matches.length}"
      while matches.length > 0 do
        matches.each_index do |i|
          puts "matches length: #{matches.length}"
          puts "index: #{i}"
          puts "matches[i]: #{matches[i]}"
          puts "guesser[matches[i]]: #{guesser[matches[i]]}"
          p guesser
          guesser[matches[i]] = nil
        end
      end
  end

  def count_clues(guesser, coder)
    correct = ""
    partial = ""
    clues = ""
    unique_guess = guesser.uniq
    
    guesser.each_with_index do |num, index|
      guesser.each_with_index do |num, index2|
        if guesser[index2] == coder.code[index2]
          puts "Correct ran"
          correct << "#{clue('correct')} "
          
          @clue_count += 1        
          puts "guesser correct: #{guesser}"
        end
      end
      matches_to_nil(computer.guess)
        if coder.code.include?(guesser[index])
          puts "Partial ran"
          partial << "#{clue('partial')} "   
          @clue_count += 1
              puts "guesser partial: #{guesser}"   
      end
    end

    @cc_index += 1
    clues = "Clues: #{correct}#{partial}"
    clues
  end

  def display_guess_clues(guesser, coder)
    color_nums = guess_to_color(guesser)
    clues = count_clues(guesser, coder)
    choice = ""

    choice << "#{color_nums}#{clues}"
    puts choice
  end

  def computer_phase1
    number_string = computer_guess.to_s
    puts "clue count: #{clue_count}"

      if clue_count == 0
        computer.guess.each_with_index do |num, index|
          computer.guess[index] = number_string
        end
      elsif clue_count > 1
        computer.guess.each_with_index do |num, index|
          computer.guess[index] = number_string
        end
        all_clues[guess_index] = (computer_guess - 1).to_s
        @guess_index += 1      
    end

    @computer_guess += 1
    @clue_count = 0
    puts "all clues: #{all_clues}"
  end


  def game_status
    if player.guess == computer.code
      puts 'GAME OVER! You Win!'
      @game_over = true
    elsif all_clues == player.code
      puts 'GAME OVER! The computer cracked the code!'
      @game_over = true
    elsif turn == 0
      puts 'GAME OVER! The code was too hard to crack!'
      @game_over = true
    end
  end

  def breaker_round
    computer.set_computer_code
    new_turn
    p computer.code
    player.get_player_guess
    display_guess_clues(player, computer)
    game_status
  end

  def maker_round
    until all_clues.length == 4 do
      puts "Computer Turns Remaining: #{turn}"
      puts "Phase 1"
      display_guess_clues(computer.guess, player)
      computer_phase1
      game_status
      @turn -= 1
    end

      puts "Computer Turns Remaining: #{turn}"
      puts "phase 2"
      display_guess_clues(all_clues, player)
      all_clues.shuffle
      game_status
      @turn -= 1

  end
end

game = Game.new(Player.new, Computer.new)
# game.player.get_player_code
# puts game.guess_to_color(game.player.code)
game.play
