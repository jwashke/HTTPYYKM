require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'
require_relative 'test_helper'

class GameTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end

  def test_game_tells_too_high
    assert_equal "Your guess is too high; try again.", @test_helper.guess_check(62, 45)
  end

  def test_game_tells_too_low
    assert_equal "Your guess is too low; try again.", @test_helper.guess_check(32, 45)
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
