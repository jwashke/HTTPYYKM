require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'

class GameTest < Minitest::Test
  def test_game_instantiates
    game = Game.new
    game.instance_of? Game
  end

  def test_game_tells_too_high
    skip
    game = Game.new
    game.guess_check(62, 45)
    assert_equal "Your guess is too high; try again.", output
  end

  def test_game_tells_too_low
    skip
    game = Game.new
    game.guess_check(32, 45)
    assert_equal "Your guess is too low; try again.", output
  end

  def test_game_tells_correct
    skip
    game = Game.new
    game.guess_check(45, 45)
    assert_equal "You got it right! Way too go!", output
  end

  def test_prints_out_players_guess
  end

  def test_game_knows_if_its_in_progress
  end

  def test_if_you_start_game_in_progress_will_give_403_error
  end




end
