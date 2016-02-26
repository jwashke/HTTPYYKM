require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/diagnostic_generator'
require 'pry'
class DiagnosticGeneratorTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end

  def test_request_diagnostic_returns_correct_information_for_request
    raw_request = {:verb=>"POST", :path=>"/", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"text/plain;charset=UTF-8", :body=>"23"}
    diagnostic = ["Verb:", "POST", "Path:", "/", "Protocol:", "HTTP/1.1", "Host:", "127.0.0.1", "Port:", "9292", "Origin:", "127.0.0.1", "Accept:"]
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end

  def test_request_diagnostic_returns_correct_information_for_request_with_get
    raw_request = {:verb=>"GET", :path=>"/hello", :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*"}
    diagnostic = ["Verb:", "GET", "Path:", "/hello", "Protocol:", "HTTP/1.1", "Host:", "127.0.0.1", "Port:", "9292", "Origin:", "127.0.0.1", "Accept:"]
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end

  def test_request_diagnostic_returns_labels_with_empty_request
    raw_request = {}
    diagnostic = ["Verb:", "Path:", "Protocol:", "Host:", "Port:", "Origin:", "Accept:"]
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end

  def test_returns_incomplete_information_if_request_is_incomplete
    raw_request = {:verb=>"GET", :path=>"/hello"}
    diagnostic = ["Verb:", "GET", "Path:", "/hello", "Protocol:", "Host:", "Port:", "Origin:", "Accept:"]
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end

end
