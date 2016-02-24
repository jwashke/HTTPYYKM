require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/response_generator'

class ResponseGeneratorTest < Minitest::Test
  def test_game_starts_with_good_luck_message
    rg = HTTP::ResponseGenerator.new
    assert_equal "Good Luck!", rg.start_game
  end

  def test_reponse_generator_starts_game_with_game_counter_as_zero
    response_generator = HTTP::ResponseGenerator.new
    response_generator.start_game
    assert_equal 0, response_generator.game_counter
  end

  def test_game_generates_random_number
    rg = HTTP::ResponseGenerator.new
    rg.start_game
    correct_num_one  = rg.correct_number
    rg2 = HTTP::ResponseGenerator.new
    rg2.start_game
    correct_num_two  = rg2.correct_number
    refute correct_num_one == correct_num_two
  end

  def test_game_count_increases_with_first_guess
skip
    rg = HTTP::ResponseGenerator.new
    rg.start_game
    assert_equal 0, rg.game_counter
    rg.guessing_game
    assert_equal 1, rg.game_counter
  end

  def test_game_count_increases_with_second_guess
    skip
    rg = ResponseGenerator.new
    rg.start_game
    assert_equal 0, game.game_counter
    rg.guessing_game
    assert_equal 1, game.game_counter
    rg.guessing_game
    assert_equal 2, game.game_counter
  end
end
