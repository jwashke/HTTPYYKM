require 'pry'
module HTTP
  class Game
    def initialize
      @game_counter = 0
      @last_guess = nil
      @correct_number = rand(1..100)
      #binding.pry
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
        # generate_output("You are being redirected.")
        # game_turn(player_guess, 'GET')
      end
    end

    def guess_check
      #binding.pry
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
