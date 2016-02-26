#require_relative 'test_helper'
#require_relative '../lib/http/server'
require 'net/http'
require 'minitest'
require 'minitest/autorun'
require 'faraday'

require 'net/http'
require 'uri'

class ServerAcceptanceTest < Minitest::Test

  def test_responds_to_HTTP_requests
    response = Faraday.get("http://127.0.0.1:9292/")
    assert_equal 0, response
  end
end

# require 'net/http'
# require 'uri'
#
# uri = URI.parse("http://www.google.com")
#
# http = Net::HTTP.new(uri.host, uri.port)
# request = Net::HTTP::Get.new("/")
#
#
# http.start
# resp = http.request request
#
# p resp.body
