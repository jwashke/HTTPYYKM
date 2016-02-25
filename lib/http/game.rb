module HTTP
  class Game
    attr_reader :correct_number
    attr_accessor :game_counter
    def initialize
      @game_counter = 0
      @correct_number = generate_random_number
    end

    def game_turn(player_guess, verb)
      verb == 'GET' ? last_guess_check : @last_guess = player_guess
    end

    def last_guess_check
      if !@last_guess.nil?
        "Your guess was #{@last_guess}. #{guess_check} Total guesses: #{@game_counter}"
      else
        "Please make a guess between 1 and 100"
      end
    end

    def guess_check
      @game_counter += 1
       if @last_guess > @correct_number
        "Your guess is too high; try again."
      elsif @last_guess < @correct_number
        "Your guess is too low; try again."
      else
        @correct_number = generate_random_number
        "You got it right! Way to go! The number has been changed, try again!"
      end
    end

    def generate_random_number
      rand(1..100)
    end
  end
end
