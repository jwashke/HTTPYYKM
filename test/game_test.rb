require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'
require_relative 'test_helper'

class GameTest < Minitest::Test
  def setup
    @game = HTTP::Game.new
  end

  def test_game_counter_initialized_to_0
    assert_equal 0, @game.game_counter
  end

  def test_game_tells_too_high
    @game.game_turn(162, "POST")
    assert_equal "Your guess is too high; try again.", @game.guess_check
  end

  def test_game_tells_too_low
    @game.game_turn(-2, "POST")
    assert_equal "Your guess is too low; try again.", @game.guess_check
  end

  def test_game_tells_correct
    @game.game_turn(42, "POST")
    assert_equal "You got it right! Way to go!", @game.guess_check
  end

  def test_game_counter_increments_correctly
    @game.game_turn(2, "POST")
    @game.guess_check
    @game.game_turn(12, "POST")
    @game.guess_check
    @game.game_turn(45, "POST")
    @game.guess_check
    assert_equal 3, @game.game_counter
  end

  def test_if_return_post_and_then_get_get_information_about_guess
    @game.game_turn(12, "POST")
    assert_equal "Your guess was 12. Your guess is too low; try again. Total guesses: 1", @game.game_turn(12, "GET")
  end

end

class HTTP::Game
  def initialize
    @correct_number = 42
    @game_counter = 0
  end


end
