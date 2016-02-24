#in Response Generator
  attr_accessor :guess_count
  attr_reader :correct_number

  def start_game
    @game_counter = 0
    @last_guess = nil
    @correct_number = rand(1..100)
    "Good Luck!"
  end

  def guessing_game(@game_counter, player_guess)
    #rewrite player_guess if not correct. if complicted create new method
    if @game_counter.nil?
      "You need to start a new game first"
    elsif @last_guess.nil?
      @game_counter +=1
      game = Game.new(player_guess, @game_counter, @last_guess = nil)
    else
      @game_counter +=1 
      game.guess_check(player_guess, correct_number)
    end
  end

module Game

  def guess_check(player_guess, correct_number)
    if player_guess > correct_number
      output = "Your guess is too high; try again."
    elsif player_guess < correct_number
      output = "Your guess is too low; try again."
    else
      "You got it right! Way too go!"
    end

  end






end
