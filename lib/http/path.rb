require 'word_search'
require 'game'
require 'diagnostic_generator'
require 'status_codes'

module HTTP
  class Path
    include DiagnosticGenerator
    include StatusCodes

    attr_reader :status_code, :word_search, :game
    attr_accessor :count

    def initialize
      @word_search = WordSearch.new
      @count = 0
      @status_code = ok
    end

    def get_path_root(request)
      @status_code = ok
      request_diagnostic(request)
    end

    def get_path_not_found
      @status_code = not_found
    end

    def get_path_datetime
      @status_code = ok
      "#{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}"
    end

    def get_path_shutdown(total_requests)
      @status_code = ok
      "Total Requests: #{total_requests}"
    end

    def get_path_hello
      @count += 1
      @status_code = ok
      "Hello World! (#{@count})"
    end

    def get_path_word_search(request)
      @status_code = ok
      word = request['Word']
      @word_search.check_word(word)
    end

    def get_path_error
      @status_code = internal_server_error
      raise SystemError
      rescue => detail
      detail.backtrace.join("\n")
    end

    def get_path_sleepy
      @status_code = ok
      sleep(3)
      "yawn..."
    end

    def get_path_start_game
      if @game.nil?
        @game = Game.new
        @status_code = found
        "Good luck!"
      else
        @status_code = forbidden
      end
    end

    def get_path_game(request)
      if @game.nil?
        @status_code = ok
        "You need to start a new game first"
      else
        @status_code = ok
        @status_code = found if request['Verb'] == 'POST'
        @game.game_turn(request['Body'].to_i, request['Verb'])
      end
    end
  end
end
