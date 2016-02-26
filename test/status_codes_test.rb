require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/status_codes'
require 'pry'

class StatusCodesTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end

  def test_status_codes_return_correct_string
    assert_equal "200 OK", @test_helper.ok
    assert_equal "302 Found", @test_helper.found
    assert_equal "401 Unauthorized", @test_helper.unauthorized
    assert_equal "403 Forbidden", @test_helper.forbidden
    assert_equal "404 Not Found", @test_helper.not_found
    assert_equal "500 Internal Server Error", @test_helper.internal_server_error

  end


end
