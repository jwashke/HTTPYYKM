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
