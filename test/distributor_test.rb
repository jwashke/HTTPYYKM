require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/distributor'
require_relative '../lib/http/path'
require 'pry'

class DistributorTest < Minitest::Test
  def setup
    @distributor = HTTP::Distributor.new
    @test_helper = TestHelper.new
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
    request_hash = @test_helper.request_hash_hello
    assert_equal "Hello World! (1)",  @distributor.path_checker(request_hash)
  end

  def test_response_says_hello_world_with_different_number
    request_hash = @test_helper.request_hash_hello
    @distributor.path_checker(request_hash)
    @distributor.path_checker(request_hash)
    assert_equal "Hello World! (3)", @distributor.path_checker(request_hash)
  end

  def test_when_redirect_request_called_total_requests_increases
    request_hash = @test_helper.request_hash_hello
    @distributor.redirect_request(request_hash)
    assert_equal 1, @distributor.total_requests
  end

  def test_path_checker_sends_to_get_path_root
    request_hash = @test_helper.request_hash_root
    assert @distributor.path_checker(request_hash) == @distributor.path.get_path_root(request_hash)
  end

  def test_path_checker_will_not_send_to_hello_if_different_path_set
    request_hash = @test_helper.request_hash_datetime
    refute "Hello World! (3)" == @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_datetime
    request_hash = @test_helper.request_hash_datetime
    time = Time.new.strftime("%a, %e %b %Y %H:%M:%S %z")
    assert_equal time, @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_shutdown
    request_hash = @test_helper.request_hash_shutdown
    assert_equal "Total Requests: 0", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_start_game
    request_hash = @test_helper.request_hash_start_game
    assert_equal "Good luck!", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search_and_request_word_if_word_nil
    request_hash = @test_helper.request_hash_word_search
    assert_equal "Please enter a word", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search_if_word_all_caps
    request_hash = @test_helper.request_hash_word_search_coffee_all_caps
    assert_equal "Coffee is a known word.", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search
    request_hash = @test_helper.request_hash_word_search_coffee
    assert_equal "Coffee is a known word.", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_word_search_with_incorrect_word
    request_hash = @test_helper.request_hash_word_search_gibberish
    assert_equal "Cfryye is not a known word.", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_error_path
    request_hash = @test_helper.request_hash_force_error
    back_trace = @distributor.path_checker(request_hash)
    assert back_trace.include?("Users")
  end

  def test_path_checker_sends_to_404_if_incorrect_path
    request_hash = @test_helper.request_hash_incorrect_path
    assert_equal "404 Not Found", @distributor.path_checker(request_hash)
  end

  def test_path_checker_sends_to_404_if_incorrect_path_different
    request_hash = @test_helper.request_hash_incorrect_path_2
    assert_equal "404 Not Found", @distributor.path_checker(request_hash)
  end

  def test_shutdown_returns_correct_total_requests_for_one
    request_hash = @test_helper.request_hash_shutdown
    @distributor.redirect_request(request_hash)
    assert_equal "Total Requests: 1", @distributor.path_checker(request_hash)
  end

  def test_shutdown_returns_correct_total_requests_for_multiples
    request_hash = @test_helper.request_hash_shutdown
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    @distributor.redirect_request(request_hash)
    assert_equal "Total Requests: 4", @distributor.path_checker(request_hash)
  end

  def test_generate_output_Output_returns_with_html_wrap
    output = "Total Requests: 1"
    @distributor.generate_output(output)
    assert_equal @test_helper.html_wrapper, @distributor.output
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
