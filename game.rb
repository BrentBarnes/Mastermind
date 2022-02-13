require_relative 'player.rb'
require_relative 'computer.rb'

class Game
  include Display
  
  attr_accessor :turn, :player, :computer, :game_over, :computer_guess, :clue_count, :guess_index, :all_clues

  def initialize(player, computer)
    @player = player
    @computer = computer
    @turn = 12
    @game_over = false
    @computer_guess = 2
    @guess_index = 0
    @clue_count = 0
    @all_clues = []
  end

  def play
    input = get_player_input
    if input == '1'
      until game_over == true do
        breaker_round
      end
    elsif input == '2'
      player.set_player_code
      until game_over == true do
        maker_round
      end
    else
      game_mode_options
      play
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

  def display_guess_clues(guesser, coder)
    color_nums = guess_to_color(guesser)
    clues = count_clues(guesser, coder)
    choice = ""

    choice << "#{color_nums}#{clues}"
    puts choice
  end

  def computer_phase1
    if clue_count == 0
      change_computer_guess
    elsif clue_count > 0
      change_computer_guess
      all_clues[guess_index] = (computer_guess - 1).to_s
      @guess_index += 1   
    end

    @computer_guess += 1
    @clue_count = 0
  end

  def change_computer_guess
    number_string = computer_guess.to_s
    computer.guess.each_index do |index|
      computer.guess[index] = number_string
    end    
  end

  def game_status
    if player.guess == computer.code
      puts 'GAME OVER! You Win!'
      @game_over = true
    elsif all_clues == player.code && all_clues != []
      display_guess_clues(all_clues, player)
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
    #Cheat mode below
    # puts "computer code: #{computer.code}"
    player.get_player_guess
    display_guess_clues(player.guess, computer)
    game_status
  end

  def maker_round
    until all_clues.length == 4 do
      turns_remaining
      display_guess_clues(computer.guess, player)
      computer_phase1
      game_status
      @turn -= 1
    end
    while game_over == false do
      turns_remaining
      @all_clues.shuffle!
      display_guess_clues(all_clues, player)
      game_status
      @turn -= 1
    end
  end
end
