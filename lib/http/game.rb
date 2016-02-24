#in Response Generator
  def start_game
    @game_counter = 0
    @last_guess = nil
    "Good Luck!"
  end

class Game
  attr_accessor :guess_count

  def initialize
    @guess_count = 0
    @correct_number = rand(1..100)
  end

  def random_num_generator


  end



end
