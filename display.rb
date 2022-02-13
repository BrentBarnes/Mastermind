require 'colorize'
require 'colorized_string'

module Display

COLORS = {'1': '  1  '.colorize(background: :yellow),
          '2': '  2  '.colorize(background: :light_green),
          '3': '  3  '.colorize(background: :blue),
          '4': '  4  '.colorize(background: :magenta),
          '5': '  5  '.colorize(background: :light_black),
          '6': '  6  '.colorize(background: :red)
}

  def rules
    puts 'HOW TO PLAY MASTERMIND:'
    puts 'This is a 1-player game against the computer.'
    puts ''
    puts 'There are six different number/color combinations'
    list_colors
    puts
    puts 'The code maker will choose four colors to create a master code.'
    puts 'For example, the code the computer sets might be:'
    puts "#{COLORS[:'6']} #{COLORS[:'4']} #{COLORS[:'3']} #{COLORS[:'1']}"
    puts 'In order to win, the code breaker must guess the master code in 12 or less turns.'
    puts
    puts 'CLUES:'
    puts 'After each guess, there will be up to four clues to help crack the code.'
    puts "#{clue('correct')} This clue means you have 1 correct number in a correct location."
    puts "#{clue('partial')} This clue means you have correct number, but you placed it in the wrong location."
    puts 'CLUE EXAMPLE:'
    puts 'Using the master code from above, a guess of \"2341\" would produce 3 clues:'
    puts "#{COLORS[:'2']} #{COLORS[:'3']} #{COLORS[:'4']} #{COLORS[:'1']} Clues: #{clue('correct')} #{clue('partial')} #{clue('partial')}"
    puts 'The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location.'
    puts
    puts 'IT\'S TIME TO PLAY!'
    game_mode_options
  end

  def game_mode_options
    puts 'Type \'1\' to be the code BREAKER.'
    puts 'Type \'2\' to be the code MAKER.'
  end

  def list_colors
    puts "#{COLORS[:'1']} #{COLORS[:'2']} #{COLORS[:'3']} #{COLORS[:'4']} #{COLORS[:'5']} #{COLORS[:'6']}"
  end

  def clue(type)
    if type == 'partial'
      partial = '0'
    else
      correct = '0'.colorize(:red).on_black
    end
  end

  def guess_to_color(guess)
    color_string = ""

    guess.each do |num|
      color_string << "#{COLORS[:"#{num}"]} "
    end
    color_string
  end

  def count_clues(guesser, coder)
  correct = ""
  partial = ""
  clues = ""
  matches = []
    
  guesser.each_with_index do |num, index|
    guesser.each_with_index do |num, index2|
      if guesser[index2] == coder.code[index2] && matches.include?(guesser[index2]) == false
        correct << "#{clue('correct')} "
        matches << guesser[index2]
        @clue_count += 1        
      end
    end
      if coder.code.include?(guesser[index]) && matches.include?(guesser[index])== false
        partial << "#{clue('partial')} "   
        @clue_count += 1  
      end
    end
    clues = "Clues: #{correct}#{partial}"
    clues
  end

  def turns_remaining
    puts "Computer Turns Remaining: #{turn}"
  end
end
