require_relative 'test_helper'
require 'minitest'
require 'minitest/autorun'
require 'faraday'

class ServerAcceptanceTest < Minitest::Test

  def setup
    @test_helper = TestHelper.new
  end

  def test_hello_status_code_and_body
    response = Faraday.get("http://127.0.0.1:9292/hello")
    assert_equal @test_helper.hello_response_body, response.body
    assert_equal 200, response.status
  end

  def test_datetime_status_code
    response = Faraday.get("http://127.0.0.1:9292/datetime")
    assert_equal 200, response.status
  end

  def test_word_search_status_code_with_found_word
    response = Faraday.get("http://127.0.0.1:9292/word_search?word=banana")
    assert_equal 200, response.status
  end

  def test_word_search_body_with_found_word
    response = Faraday.get("http://127.0.0.1:9292/word_search?word=banana")
    assert_equal 0, response.body
  end

  def test_word_search_status_code_with_not_found_word
    response = Faraday.get("http://127.0.0.1:9292/word_search?word=banana")
    assert_equal 200, response.status
  end

  def test_word_search_body_with_not_found_word
    response = Faraday.get("http://127.0.0.1:9292/word_search?word=banana")
    assert_equal 0, response.body
  end

  # def test_root_status_code
  #   response = Faraday.get("http://127.0.0.1:9292/shutdown")
  #   assert_equal 200, response.status
  # end

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
