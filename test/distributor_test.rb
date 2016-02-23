require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/distributor'
require 'pry'

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

  def test_when_parse_request_called_total_requests_increases
    assert_equal 0, @distributor.total_requests
    raw_request = ["GET / HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert_equal 1, @distributor.total_requests
  end

  def test_parse_request_instantiates_request_parser
    # skip
    raw_request = ["GET / HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert @request.instance_of? HTTP::RequestParser
  end


end
