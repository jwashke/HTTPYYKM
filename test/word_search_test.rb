require 'minitest'
require 'minitest/autorun'
require_relative 'test_helper'
require_relative '../lib/http/word_search'

class WordSearchTest < Minitest::Test
  def setup
    @word_search = HTTP::WordSearch.new
  end

  def test_it_can_check_dictionary_includes_a_word
    assert_equal "pizza is a known word", @word_search.check_word("pizza")
  end

  def test_it_can_check_dictionary_doesnt_include_a_word
    assert_equal "pizzaaaaa is not a known word", @word_search.check_word("pizzaaaaa")
  end
end
