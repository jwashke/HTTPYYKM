require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/distributor'
require_relative '../lib/http/path'
require 'pry'

class DistributorTest < Minitest::Test
  def setup
    @distributor = HTTP::Distributor.new
  end

  def test_distributor_instantiates
    @distributor.instance_of? HTTP::Distributor
  end

  def test_distributor_instantiates_path
    assert @distributor.path.instance_of? HTTP::Path
  end

  def test_distributor_initalizes_total_requests_as_zero
    assert_equal 0, @distributor.total_requests
  end

  def test_response_says_hello_world_with_get_path_hello
    path = HTTP::Path.new
    request_hash = {:verb=>"GET", 'Path'=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Hello World! (1)",  @distributor.path_checker(request_hash)
  end

  def test_response_says_hello_world_with_different_number
    request_hash = {:verb=>"GET", 'Path'=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    @distributor.path_checker(request_hash)
    assert_equal "Hello World! (3)", @distributor.path_checker(request_hash)
  end

  def test_when_redirect_request_called_total_requests_increases
    request_hash = {:verb=>"GET", 'Path'=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal 1, @distributor.total_requests
  end

  def test_path_checker_sends_to_get_path_root
    request_hash = {:verb=>"GET", 'Path'=>"/", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert @distributor.path_checker(request_hash) == @distributor.path.get_path_root(request_hash)
  end

  def test_path_checker_will_not_send_to_hello_if_different_path_set
    request_hash = {:verb=>"GET", 'Path'=>"/datetime", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    refute "Hello World! (3)" == @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_datetime
    request_hash = {:verb=>"GET", 'Path'=>"/datetime", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    time = Time.new.strftime("%a, %e %b %Y %H:%M:%S %z")
    assert_equal time, @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_shutdown
    request_hash = {:verb=>"GET", 'Path'=>"/shutdown", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Total Requests: 0", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_start_game
    request_hash = {:verb=>"GET", 'Path'=>"/start_game", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Good luck!", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_game_with_notice_if_start_game_hasnt_happened
    request_hash = {:verb=>"GET", 'Path'=>"/start_game", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    request_hash = {:verb=>"GET", 'Path'=>"/game", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Please make a guess between 1 and 100", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search_and_request_word_if_word_nil
    request_hash = {:verb=>"GET", 'Path'=>"/word_search", 'Word'=>nil, :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Please enter a word", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search_if_word_all_caps
    request_hash = {:verb=>"GET", 'Path'=>"/word_search", 'Word'=>"COFFEE", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Coffee is a known word.", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search
    request_hash = {:verb=>"GET", 'Path'=>"/word_search", 'Word'=>"coffee", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Coffee is a known word.", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search_with_incorrect_word
    request_hash = {:verb=>"GET", 'Path'=>"/word_search", 'Word'=>"cfryye", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Cfryye is not a known word.", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_error_path
    request_hash = {:verb=>"GET", 'Path'=>"/force_error", 'Word'=>"cfryye", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    back_trace = @distributor.path_checker(request_hash)
    assert back_trace.include?("Users")
  end

  def test_path_checker_sends_to_404_if_incorrect_path
    request_hash = {:verb=>"GET", 'Path'=>"/lolz", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "404 Not Found", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_404_if_incorrect_path_different
    request_hash = {:verb=>"GET", 'Path'=>"/wowww", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "404 Not Found", @distributor.path_checker(request_hash)
  end

  def test_shutdown_returns_correct_total_requests_for_one
    request_hash = {:verb=>"GET", 'Path'=>"/shutdown", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal "Total Requests: 1", @distributor.path_checker(request_hash)
  end

  def test_shutdown_returns_correct_total_requests_for_multiples
    request_hash = {:verb=>"GET", 'Path'=>"/shutdown", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    assert_equal "Total Requests: 4", @distributor.path_checker(request_hash)
  end

  def test_generate_output_Output_returns_with_html_wrap
    output = "Total Requests: 1"
    @distributor.generate_output(output)
    assert_equal "<html><head></head><body><pre>Total Requests: 1</pre></body></html>", @distributor.output
  end

  def test_generate_output_header_has_correct_beginning
    output = "Total Requests: 1"
    @distributor.generate_output(output)
    assert_equal "HTTP/1.1", @distributor.header.split[0]
  end

  def test_generate_output_gives_correct_header_for_a_diff_status_code
    output = "Total Requests: 1"
    @distributor.generate_output(output, "404 Not Found")
    assert_equal "HTTP/1.1", @distributor.header.split[0]
  end

end
