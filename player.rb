class Player
  include Display
  attr_accessor :guess, :code

  def initialize
    @guess = nil
    @code = []
  end

  def get_player_guess
    guess = gets.chomp.split('')

    if guess.length != 4
      puts "You should enter four numbers exactly for your turn. Make your guess now."
      get_player_guess
    else
      @guess = guess
    end
  end

  def set_player_code
    get_player_code
    guess_to_color(code)
  end

  def get_player_code
    puts 'Enter a 4 digit \'master code\' for the computer to break'
    code = gets.chomp.split('')
    
    if code.length != 4
      puts "You should enter four numbers exactly for your turn. Make your guess now."
      get_player_code
    else
      @code = code
    end
  end
end
