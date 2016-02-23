require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/distributor'

class DistributorTest < Minitest::Test
  def test_distributor_instantiates
    distributor = Distributor.new
    distributor.instance_of? Distributor
  end

  def test_response_says_hello_world_with_number
    skip
    server = Distributor.new
    server.response
    assert_equal "Hello World (0)", response(0)
  end

  def test_response_says_hello_world_with_different_number
    skip
    server = Distributor.new
    server.response
    assert_equal "Hello World (25)", response(25)
  end

  def test_output_passes_response_to_response_method
    skip
    server = Distributor.new
    assert_equal "Hello World (0)", server.output(response(5))
  end


end
