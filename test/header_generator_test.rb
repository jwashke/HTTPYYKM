require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/header_generator'

class HeaderGeneratorTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end
end
