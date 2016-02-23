require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/html_generator'
require 'pry'

class HTMLGeneratorTest < Minitest::Test
  def test_wrap_respons_adds_pre_before_and_after_content
    assert_equal "<pre> Hi there </pre>", wrap_response("Hi there ")

  end

end
