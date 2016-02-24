require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/html_generator'
require_relative 'test_helper'
require 'pry'

class HTMLGeneratorTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
  end

  def test_wrap_response_adds_pre_before_and_after_content
    assert_equal "<pre>Hi there</pre>", @test_helper.wrap_response("Hi there")
  end

  def test_generate_html_adds_html_content_to_wrapped_response
    assert_equal "<html><head></head><body><pre>Hi there</pre></body></html>", @test_helper.generate_html("Hi there")
  end

end
