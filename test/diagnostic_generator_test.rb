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
    raw_request = @test_helper.request_hash_root_post
    diagnostic = @test_helper.diagnostic_post
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end

  def test_request_diagnostic_returns_correct_information_for_request_with_get
    raw_request = @test_helper.request_hash_hello
    diagnostic = @test_helper.diagnostic_get
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end

  def test_request_diagnostic_returns_labels_with_empty_request
    raw_request = {}
    diagnostic = @test_helper.diagnostic_empty
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end

  def test_returns_incomplete_information_if_request_is_incomplete
    raw_request = {:verb=>"GET", :path=>"/hello"}
    diagnostic = @test_helper.diagnostic_incomplete
    assert_equal diagnostic, (@test_helper.request_diagnostic(raw_request)).split
  end
end
