class Computer
  attr_accessor :guess, :code

  def initialize
    @guess = ['1', '1', '1', '1']
    @code = []
    @clues = 0
  end

  def random_number
      Random.rand(1..6)
  end

  def set_computer_code
    until code.length == 4 do
      num = random_number.to_s
      if code.include?(num)
      else
        code << num
      end
    end
  end
end
