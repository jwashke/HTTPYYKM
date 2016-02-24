require_relative 'word_search'
require_relative 'game'
require_relative 'status_codes'

module HTTP
  class ResponseGenerator
    include StatusCodes
    attr_accessor :game_counter
    attr_reader :correct_number

    def initialize
      @hello_count    = 0
      @total_requests = 0
    end

    def root

    end

    def not_found

    end

    def datetime

    end

    def hello

    end

    def shutdown

    end

    def word_search

    end

    def start_game
      @game_counter = 0
      @last_guess = nil
      @correct_number = rand(1..100)
      output = "Good Luck!"
    end

    def guessing_game(player_guess)
      #rewrite player_guess if not correct. if complicted create new method
      if @game_counter.nil?
        "You need to start a new game first"
      elsif @last_guess.nil?
        @game_counter +=1
        game = Game.new(player_guess, @game_counter, @last_guess = nil)
      else
        @game_counter +=1
        game.guess_check(player_guess, correct_number)
      end
    end

  end
end
