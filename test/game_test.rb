require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'

class GameTest < Minitest::Test
  def test_game_starts_with_good_luck_message
    skip
    #can move to response_generator_test just keeping it here for now
    rg = ResponseGenerator.new
    assert_equal "Good Luck!", rg.game_start
  end

  def test_game_instantiates
    skip
    game = Game.new
    game.instance_of? Game
  end

  def test_game_instantiates_guess_count_as_zero
    skip
    game = Game.new
    assert_equal 0, game.guess_count
  end

  def test_game_generates_random_number
    skip
    game = Game.new
    correct_num_one  = game.random_num_generator
    game = Game.new 
    correct_num_two  = game.random_num_generator
    refute correct_num_one == correct_num_two
  end

  def test_game_tells_too_high
  end

  def test_game_tells_too_low
  end

  def test_game_tells_correct
  end

  def test_prints_out_players_guess
  end

  def test_game_knows_if_its_in_progress
  end

  def test_if_you_start_game_in_progress_will_give_403_error
  end




end
