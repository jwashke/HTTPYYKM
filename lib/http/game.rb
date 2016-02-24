module HTTP
  class Game
    def intialize
      @game_counter = 0
      @last_guess = nil
      @correct_number = rand(1..100)
    end

    # def get_path_game
    #   if @request[:verb] == 'POST'
    #     get_path_guessing_game
    #   else
    #     output_game_info
    #   end
    # end

    def game_turn(player_guess, verb)
      if verb == 'GET'
        if !last_guess.nil?
          "Your guess was #{player_guess}. #{check_guess(player_guess)} Total guesses: #{@game_counter}"
        else
          "Please make a guess between 1 and 100"
        end
      end #add else here
    end





    # def get_path_guessing_game
    #   if @game_counter.nil?
    #     "You need to start a new game first"
    #   else
    #     @game_counter +=1
    #     guess_check(@request[:body].to_i, @correct_number)
    #   end
    # end

    def guess_check(player_guess)
      if player_guess > @correct_number
        "Your guess is too high; try again."
      elsif player_guess < @correct_number
        "Your guess is too low; try again."
      else
        "You got it right! Way to go!"
      end

    end

  end
end
