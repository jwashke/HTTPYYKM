require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/status_codes'
require 'pry'

class StatusCodesTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end
  
  def test_200_return_correct_string
    assert_equal "200 OK", @test_helper.ok
  end

  def test_302_returns_correct_string
    assert_equal "302 Found", @test_helper.found
  end

  def test_401_returns_correct_string
    assert_equal "401 Unauthorized", @test_helper.unauthorized
  end

  def test_403_returns_correct_string
    assert_equal "403 Forbidden", @test_helper.forbidden
  end

  def test_404_returns_correct_string
    assert_equal "404 Not Found", @test_helper.not_found
  end

  def test_500_returns_correct_string
    assert_equal "500 Internal Server Error", @test_helper.internal_server_error
  end
end
