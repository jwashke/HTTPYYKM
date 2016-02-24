require 'pry'
module HTTP
  class WordSearch
    def initialize
      @dictionary = File.read("/usr/share/dict/words")
    end

    def check_word(word)
      @dictionary.include?(word) ? is_word(word) : is_not_word(word)
    end

    def is_word(word)
      "#{word} is a known word"
    end

    def is_not_word(word)
      "#{word} is not a known word"
    end
  end
end
