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
    distributor = Distributor.new
    distributor.response
    assert_equal "Hello World (0)", response(0)
  end

  def test_response_says_hello_world_with_different_number
    skip
    distributor = Distributor.new
    distributor.response
    assert_equal "Hello World (25)", response(25)
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

  def test_parsing_file_outputs_correct_diagnostics_for_verb
    skip
    distributor = Distributor.new
    request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
    assert_equal "Verb: POST" distributor.parsing_file(request_array)[0]
  end

  def test_parsing_file_outputs_correct_diagnostics_for_path
    skip
    distributor = Distributor.new
    request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
    assert_equal "Path: /hello_world" distributor.parsing_file(request_array)[1]
  end

  def test_parsing_file_outputs_correct_diagnostics_for_protocol
    skip
    distributor = Distributor.new
    request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
    assert_equal "Protocol: HTTP/1.1" distributor.parsing_file(request_array)[2]
  end

  def test_parsing_file_outputs_correct_diagnostics_for_host
    skip
    distributor = Distributor.new
    request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
    assert_equal "Host: 127.0.0.1" distributor.parsing_file(request_array)[3]
  end

end
