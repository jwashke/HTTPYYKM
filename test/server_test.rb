require_relative 'test_helper'
require 'minitest'
require 'minitest/autorun'
require 'faraday'

class ServerTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end

  def test_hello_status_code_and_body
    response = Faraday.get("http://127.0.0.1:9292/hello")
    assert_equal @test_helper.hello_body, response.body
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
    assert_equal @test_helper.found_word, response.body
  end

  def test_word_search_status_code_with_not_found_word
    response = Faraday.get("http://127.0.0.1:9292/word_search?word=banana")
    assert_equal 200, response.status
  end

  def test_word_search_body_with_not_found_word
    response = Faraday.get("http://127.0.0.1:9292/word_search?word=branana")
    assert_equal @test_helper.not_found_word, response.body
  end

  def test_start_game_status_codes_in_order
    response = Faraday.get("http://127.0.0.1:9292/start_game")
    assert_equal 302, response.status
    response = Faraday.get("http://127.0.0.1:9292/start_game")
    assert_equal 403, response.status
    response = Faraday.get("http://127.0.0.1:9292/game")
    assert_equal 200, response.status
    response = Faraday.post("http://127.0.0.1:9292/game", { 'guess' => 50 })
    assert_equal 302, response.status
  end

  def test_force_error_status_code
    response = Faraday.get("http://127.0.0.1:9292/force_error")
    assert_equal 500, response.status
  end

  def test_not_found_status_code
    response = Faraday.get("http://127.0.0.1:9292/sffsdgs")
    assert_equal 404, response.status
  end

  def test_not_found_body
    response = Faraday.get("http://127.0.0.1:9292/sffsdgs")
    assert_equal @test_helper.not_found_body, response.body
  end
end
