require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'

class GameTest < Minitest::Test
  def test_game_starts_with_good_luck_message
    skip
    #can move to response_generator_test just keeping it here for now
    rg = ResponseGenerator.new
    assert_equal "Good Luck!", rg.game_start.output
  end

  def test_game_instantiates
    game = Game.new
    game.instance_of? Game
  end

  def test_reponse_generator_guess_count_as_zero
    skip
    rg = ResponseGenerator.new
    assert_equal 0, response_generator.guess_count
  end

  def test_game_generates_random_number
    rg = ResponseGenerator.new
    correct_num_one  = rg.correct_number
    rg = ResponseGenerator.new
    correct_num_two  = rg.correct_number
    refute correct_num_one == correct_num_two
  end

  def test_game_count_increases_with_first_guess
    skip
    rg = ResponseGenerator.new
    rg.start_game
    assert_equal 0, rg.guess_count
    rg.guessing_game
    assert_equal 1, rg.guess_count
  end

  def test_game_count_increases_with_second_guess
    skip
    rg = ResponseGenerator.new
    rg.start_game
    assert_equal 0, game.guess_count
    rg.guessing_game
    assert_equal 1, game.guess_count
    rg.guessing_game
    assert_equal 2, game.guess_count
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
