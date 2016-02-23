require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/distributor'

class DistributorTest < Minitest::Test
  def setup
    @distributor = HTTP::Distributor.new
  end

  def test_distributor_instantiates
    @distributor.instance_of? HTTP::Distributor
  end

  def distributor_initalizes_shutdown_as_false
    refute @distributor.shutdown
  end

  def distributor_initalizes_total_requests_as_zero
    assert_equal 0, @distributor.total_requests
  end

  def distributor_initalizes_count_as_zero
    assert_equal 0, @distributor.count
  end
# meta wow: true
  def test_response_says_hello_world_with_get_path_hello
    @distributor.get_path_hello
    assert_equal "<html><head></head><body><pre>Hello World! (1)</pre></body></html>", @distributor.output
  end

  def test_response_says_hello_world_with_different_number
    @distributor.get_path_hello
    @distributor.get_path_hello
    @distributor.get_path_hello
    assert_equal "<html><head></head><body><pre>Hello World! (3)</pre></body></html>", @distributor.output
  end

  def test_output_passes_response_to_response_method
    skip
    distributor = Distributor.new
    assert_equal "Hello World (0)", distributor.output(response(5))
  end

  def test_process_request_outputs_all_of_response_information_correctly
    skip
    distributor = Distributor.new
    assert_equal " ", distributor.process_request(X, 5)[0]
    assert_equal " ", distributor.process_request(X, 5)[1]
  end

  def test_parsing_file_outputs_correct_diagnostics_for_accept
    skip
    distributor = Distributor.new
    request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", distributor.parsing_file(request_array)[6]
  end

end
