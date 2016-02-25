require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/distributor'
require_relative '../lib/http/path'
require_relative 'test_helper'
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
    path = HTTP::Path.new
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    assert_equal "Hello World! (1)",  @distributor.path_checker(request_hash)
  end

  def test_response_says_hello_world_with_different_number
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    @distributor.path_checker(request_hash)
    @distributor.path_checker(request_hash)
    assert_equal "<html><head></head><body><pre>Hello World! (3)</pre></body></html>", @distributor.output
  end

  def test_when_parse_request_called_total_requests_increases
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal 1, @distributor.total_requests
  end

  def test_parse_request_instantiates_path
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert @request.instance_of? HTTP::Path
  end

  def test_path_checker_sends_to_get_path_root
    skip
    request_hash = {:verb=>"GET", :path=>"/", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal " ", output
  end

  def test_path_checker_sends_to_root_and_200_status
    skip
    request_hash = {:verb=>"GET", :path=>"/", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    time = Time.new.strftime("%a, %e %b %Y %H:%M:%S %z")
    assert_equal "200", @distributor.path_checker.split[1]
  end

  def test_path_checker_sends_to_hello
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal " ", output
  end

  def test_path_checker_will_not_send_to_datetime_if_different_path_set
    skip
    request_hash = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.parse_request(raw_request)
    refute @distributor.path_checker(request_hash) == @path.get_path_datetime
  end

  def test_path_checker_sends_to_datetime
    skip
    request_hash = {:verb=>"GET", :path=>"/datetime", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal " ", output
  end

  def test_path_checker_sends_to_shutdown
    skip
    request_hash = {:verb=>"GET", :path=>"/shutdown", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal " ", output
  end

  def test_path_checker_sends_to_word_search
    skip
    request_hash = {:verb=>"GET", :path=>"/word_search", :word=>"coffee", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal " ", output
  end

  def test_path_checker_sends_to_404_if_incorrect_path
    skip
    request_hash = {:verb=>"GET", :path=>"/lolz", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal " ", output
  end

  def test_path_checker_sends_to_404_if_incorrect_path_different
    skip
    request_hash = {:verb=>"GET", :path=>"/wowww", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal " ", output
  end

  def test_shutdown_returns_correct_total_requests
    skip
    request_hash = {:verb=>"GET", :path=>"/shutdown", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    @distributor.path_checker(request_hash)
    assert_equal "<html><head></head><body><pre>Total Requests: 1</pre></body></html>", @distributor.output
  end

end
