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
    assert_equal "You got it right! Way too go!", @test_helper.guess_check(45, 45)
  end



end
