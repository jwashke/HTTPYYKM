require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/html_generator'
require 'pry'

class HTMLGeneratorTest < Minitest::Test
  def test_wrap_response_adds_pre_before_and_after_content
    skip
    assert_equal "<pre> Hi there </pre>", wrap_response("Hi there ")
  end

  def test_generate_html_adds_html_content_to_wrapped_response
    skip 
    assert_equal "<pre> Hi there </pre>", generate_html("Hi there ")
  end

end
