require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/path'
require_relative 'test_helper'

class PathTest < Minitest::Test
  def setup
    @path = HTTP::Path.new
  end

  def test_path_initalizes_count_as_zero
    assert_equal 0, @path.count
  end

  def test_path_initializes_with_ws_instance
    assert @path.word_search.instance_of? HTTP::WordSearch
  end

  def test_get_path_root_returns_diagnostic_info
    request_hash = {:verb=>"GET", :path=>"/", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal ["Verb:", "GET", "Path:", "/", "Protocol:", "HTTP/1.1", "Host:", "127.0.0.1", "Port:", "9292", "Origin:", "127.0.0.1", "Accept:"], @path.get_path_root(request_hash).split
  end

  def test_get_path_not_found_returns_correct_status_code
    assert_equal "404 Not Found", @path.get_path_not_found
    assert_equal "404 Not Found", @path.status_code
  end

  def test_get_path_datetime_returns_correct_date_and_time
    time = Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')
    assert_equal time, @path.get_path_datetime
  end

  def test_get_path_datetime_returns_correct_status_code
    @path.get_path_datetime
    assert_equal "200 OK", @path.status_code
  end

  def test_get_path_shutdown_returns_correct_number_of_trs
     assert_equal "Total Requests: 4", @path.get_path_shutdown(4)
  end

  def test_returns_hello_with_correct_count
    assert_equal "Hello World! (1)", @path.get_path_hello
    assert_equal "Hello World! (2)", @path.get_path_hello
    assert_equal "Hello World! (3)", @path.get_path_hello
    assert_equal "Hello World! (4)", @path.get_path_hello
    assert_equal "Hello World! (5)", @path.get_path_hello
  end

  def test_returns_correct_word_search_output_for_correct_word
    request_hash = {:verb=>"GET", :path=>"/word_search", :word=>"milk", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Milk is a known word.", @path.get_path_word_search(request_hash)
  end

  def test_returns_correct_word_search_output_for_incorrect_word
    request_hash = {:verb=>"GET", :path=>"/word_search", :word=>"wlekje", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Wlekje is not a known word.", @path.get_path_word_search(request_hash)
  end

  def test_game_starts_with_good_luck_message
    assert_equal "Good luck!", @path.get_path_start_game
  end

  def test_game_start_has_correct_status_code
    @path.get_path_start_game
    assert_equal "302 Found", @path.status_code
  end

  def test_game_returns_forbidden_status_code_correctly
    @path.get_path_start_game
    @path.get_path_start_game
    assert_equal "403 Forbidden", @path.status_code
  end

  def test_game_get_path_game_returns_correct_status_code_if_game_nil
    request_hash = {:verb=>"GET", :path=>"/game", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @path.get_path_game(request_hash)
    assert_equal "200 OK", @path.status_code
  end

  def test_game_get_path_game_returns_prompt_if_no_start_game
    request_hash = {:verb=>"GET", :path=>"/game", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "You need to start a new game first", @path.get_path_game(request_hash)
  end

  def test_game_will_redirect_to_game_turn_and_last_guess_if_game_has_begun
    request_hash = {:verb=>"POST", :path=>"/game", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @path.get_path_start_game
    assert_equal 0, @path.get_path_game(request_hash)
  end

end
