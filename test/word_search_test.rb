require 'minitest/autorun'
require 'minitest/pride'
require_relative 'test_helper'
require_relative '../lib/http/word_search'

class WordSearchTest < Minitest::Test
  def setup
    @word_search = HTTP::WordSearch.new
  end

  def test_it_can_check_dictionary_includes_a_word
    assert_equal "Pizza is a known word.", @word_search.check_word("pizza")
  end

  def test_it_can_check_dictionary_doesnt_include_a_word
    assert_equal "Pizzaaaaa is not a known word.", @word_search.check_word("pizzaaaaa")
  end

  def test_it_can_check_dictionary_if_word_empty
    skip
    assert_equal " is a known word.", @word_search.check_word("")
  end

  #double words, empty, nil,
end
