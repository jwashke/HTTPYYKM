require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/game'

class Game2Test < Minitest::Test
  def setup
    @game_2 = HTTP::Game.new
  end

  def test_game_counter_is_initalized_at_zero_in_initial_game
    assert_equal 0, @game_2.game_counter
  end
end
