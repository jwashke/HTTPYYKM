require 'pry'
module HTTP
  class Game
    def initialize
      @game_counter = 0
      @last_guess = nil
      @correct_number = rand(1..100)
    end

    def game_turn(player_guess, verb)
      if verb == 'GET'
        if !@last_guess.nil?
          "Your guess was #{@last_guess}. #{guess_check} Total guesses: #{@game_counter}"
        else
          "Please make a guess between 1 and 100"
        end
      else
        @last_guess = player_guess
      end
    end

    def guess_check
      @game_counter += 1
       if @last_guess > @correct_number
        "Your guess is too high; try again."
      elsif @last_guess < @correct_number
        "Your guess is too low; try again."
      else
        "You got it right! Way to go!"
      end

    end

  end
end
