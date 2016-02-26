require 'pry'
module HTTP
  class WordSearch
    def initialize
      @dictionary = File.read("/usr/share/dict/words")
    end

    def check_word(word)
      return "Please enter a word" if word.nil?
      @dictionary.include?(word.downcase) ? is_word(word.downcase) : is_not_word(word)
    end

    def is_word(word)
      "#{word.capitalize} is a known word."
    end

    def is_not_word(word)
      "#{word.capitalize} is not a known word."
    end
  end
end
