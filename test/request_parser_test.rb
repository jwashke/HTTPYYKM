require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/request_parser'
require_relative '../lib/http/distributor'
require 'pry'

class RequestParserTest < Minitest::Test
  def setup
    @request_parser = HTTP::RequestParser.new
  end

  def test_request_parser_instantiates
    assert @request_parser.instance_of? HTTP::RequestParser
  end

  def test_request_parser_has_empty_hash_initially
    assert_equal ({}), @request_parser.request_hash
  end

  def test_request_parser_produces_correct_request_hash
    skip 
    @distributor = HTTP::Distributor.new
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
    hash = {:verb=>"GET",
            :path=>"/",
            :protocol=>"HTTP/1.1",
            :host=>"127.0.0.1",
            :port=>"9292",
            :origin=>"127.0.0.1",
            :Accept=>"*/*"}
    assert_equal hash, @request_parser.request_hash
  end
end
