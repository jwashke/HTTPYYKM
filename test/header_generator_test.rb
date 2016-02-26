require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/header_generator'
require_relative 'test_helper'

class HeaderGeneratorTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end

  def test_generate_header_returns_correct_header_info
    output = @test_helper.generate_header(144, "302 Found")
    output_answer = ["http/1.1", "302", "Found", "date:"]
    assert_equal output_answer, output.split[0..3]
  end
end
