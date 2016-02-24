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
    skip
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

  def test_redirect_request_sends_to_get_path_root
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
    assert @distributor.redirect_request == @distributor.get_path_root
  end

  def test_redirect_request_sends_to_root_and_200_status
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
    time = Time.new.strftime("%a, %e %b %Y %H:%M:%S %z")
    assert_equal "200", @distributor.redirect_request.split[1]
  end

  def test_redirect_request_sends_to_hello
    raw_request = ["GET /hello HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert @distributor.redirect_request == @distributor.get_path_hello
  end

  def test_redirect_request_will_not_sends_to_datetime_if_different_path_set
    raw_request = ["GET /hello HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    refute @distributor.redirect_request == @distributor.get_path_datetime
  end

  def test_redirect_request_sends_to_datetime
    raw_request = ["GET /datetime HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert @distributor.redirect_request == @distributor.get_path_datetime
  end

  def test_redirect_request_sends_to_shutdown
    raw_request = ["GET /shutdown HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert @distributor.redirect_request == @distributor.get_path_shutdown
  end

  def test_redirect_request_sends_to_shutdown
    skip
    raw_request = ["GET /word_search HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert @distributor.redirect_request == @distributor.word_search
  end

  def test_redirect_request_sends_to_404_if_incorrect_path
    raw_request = ["GET /mama HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert_equal "http/1.1 404 Not Found", @distributor.header.split("\n")[0].chomp
  end

  def test_redirect_request_sends_to_404_if_incorrect_path_different
    raw_request = ["GET /wowza HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert_equal "http/1.1 404 Not Found", @distributor.header.split("\n")[0].chomp
  end

  def test_redirect_request_gives_date_and_time_with_datetime_path
    raw_request = ["GET /datetime HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    time = Time.new.strftime("%a, %e %b %Y %H:%M:%S %z")
    assert_equal "date: #{time}", @distributor.header.split("\n")[1].chomp
  end

  def test_shutdown_returns_correct_total_requests
    raw_request = ["GET /shutdown HTTP/1.1",
                   "Host: 127.0.0.1:9292",
                   "Connection: keep-alive",
                   "Cache-Control: no-cache",
                   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
                   "Postman-Token: 13cf4695-cc4b-f80e-709c-2f46dbdd8b29",
                   "Accept: */*",
                   "Accept-Encoding: gzip, deflate, sdch",
                   "Accept-Language: en-US,en;q=0.8"]
    @distributor.parse_request(raw_request)
    assert_equal "<html><head></head><body><pre>Total Requests: 1</pre></body></html>", @distributor.output
  end

  def test_generate_output_works_properly_for_shutdown
    generated_output = @distributor.generate_output("Total Requests: 1")
    assert_equal "http/1.1 200 OK", generated_output.split("\n")[0].chomp
  end

  def test_get_header_produces_correct_header_for_shutdown
    skip
    output = "<html><head></head><body><pre>Total Requests: 1</pre></body></html>"
    status_code = "200 OK"
    get_header_output = @distributor.get_header(output, status_code)
    assert_equal " ", get_header_output
    assert_equal " ", get_header_output.output
  end

  def test_request_diagnostic_returns_correct_output

  end

  def test_shutdown_returns_correct_output

  end





end
