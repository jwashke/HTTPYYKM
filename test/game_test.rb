require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'
require_relative 'test_helper'

class GameTest < Minitest::Test
  def setup
    @game = HTTP::Game.new
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
    skip
    assert_equal "You got it right! Way too go!", @game.guess_check(45, 45)
  end


end
