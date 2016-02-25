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

  def distributor_initalizes_total_requests_as_zero
    assert_equal 0, @distributor.total_requests
  end

  def test_response_says_hello_world_with_get_path_hello
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal "<html><head></head><body><pre>Hello World! (1)</pre></body></html>", @distributor.output
  end

  def test_response_says_hello_world_with_different_number
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    assert_equal "<html><head></head><body><pre>Hello World! (3)</pre></body></html>", @distributor.output
  end

  def test_when_parse_request_called_total_requests_increases
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal 1, @distributor.total_requests
  end

  def test_parse_request_instantiates_path
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert @request.instance_of? HTTP::Path
  end

  def test_redirect_request_sends_to_get_path_root
    skip
    request_hash = {:verb=>"GET", :path=>"/", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal " ", output
  end

  def test_redirect_request_sends_to_root_and_200_status
    skip
    request_hash = {:verb=>"GET", :path=>"/", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    time = Time.new.strftime("%a, %e %b %Y %H:%M:%S %z")
    assert_equal "200", @distributor.redirect_request.split[1]
  end

  def test_redirect_request_sends_to_hello
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal " ", output
  end

  def test_redirect_request_will_not_send_to_datetime_if_different_path_set
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.parse_request(raw_request)
    refute @distributor.redirect_request(request_hash) == @path.get_path_datetime
  end

  def test_redirect_request_sends_to_datetime
    skip
    request_hash = {:verb=>"GET", :path=>"/datetime", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal " ", output
  end

  def test_redirect_request_sends_to_shutdown
    skip
    request_hash = {:verb=>"GET", :path=>"/shutdown", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal " ", output
  end

  def test_redirect_request_sends_to_word_search
    skip
    request_hash = {:verb=>"GET", :path=>"/word_search", :word=>"coffee", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal " ", output
  end

  def test_redirect_request_sends_to_404_if_incorrect_path
    skip
    request_hash = {:verb=>"GET", :path=>"/lolz", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal " ", output
  end

  def test_redirect_request_sends_to_404_if_incorrect_path_different
    skip
    request_hash = {:verb=>"GET", :path=>"/wowww", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal " ", output
  end

  def test_shutdown_returns_correct_total_requests
    skip
    request_hash = {:verb=>"GET", :path=>"/shutdown", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.redirect_request(request_hash)
    assert_equal "<html><head></head><body><pre>Total Requests: 1</pre></body></html>", @distributor.output
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

  class ResponseGeneratorTest < Minitest::Test
    def test_game_starts_with_good_luck_message
      rg = HTTP::ResponseGenerator.new
      assert_equal "Good Luck!", rg.start_game
    end

    def test_reponse_generator_starts_game_with_game_counter_as_zero
      response_generator = HTTP::ResponseGenerator.new
      response_generator.start_game
      assert_equal 0, response_generator.game_counter
    end

    def test_game_generates_random_number
      rg = HTTP::ResponseGenerator.new
      rg.start_game
      correct_num_one  = rg.correct_number
      rg2 = HTTP::ResponseGenerator.new
      rg2.start_game
      correct_num_two  = rg2.correct_number
      refute correct_num_one == correct_num_two
    end

    def test_game_count_increases_with_first_guess
      rg = HTTP::ResponseGenerator.new
      rg.start_game
      assert_equal 0, rg.game_counter
      rg.guessing_game(47)
      assert_equal 1, rg.game_counter
    end

    def test_game_count_increases_with_second_guess
      rg = HTTP::ResponseGenerator.new
      rg.start_game
      assert_equal 0, rg.game_counter
      rg.guessing_game(47)
      assert_equal 1, rg.game_counter
      rg.guessing_game(19)
      assert_equal 2, rg.game_counter
    end

    def test_prints_out_players_guess
    end

    def test_game_knows_if_its_in_progress
    end

    def test_if_you_start_game_in_progress_will_give_403_error
    end

  end




end
