require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/request_parser'
require 'pry'

class RequestParserTest < Minitest::Test
  def setup
    @request_parser = HTTP::RequestParser.new
  end

  def test_request_parser_instantiates
    assert @request_parser.instance_of? HTTP::RequestParser
  end
end
