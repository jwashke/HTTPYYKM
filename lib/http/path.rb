require_relative 'word_search'
require_relative 'game'
require_relative 'output_generator'

module HTTP
  class Path
    include OutputGenerator

    attr_reader :status_code

    def initialize
      @word_search = WordSearch.new
      @count = 0
      @status_code
    end

    def get_path_root(request)
      request_diagnostic(request)
    end

    def get_path_not_found
      @status_code = "404 Not Found"
      "404 Not Found"
    end

    def get_path_datetime
      @status_code = "200 OK"
      "#{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}"
    end

    def get_path_shutdown(total_requests)
      "Total Requests: #{total_requests}"
    end

    def get_path_hello
      @count += 1
      "Hello World! (#{@count})"
    end

    def get_path_word_search(request)
      word = request[:word]
      @word_search.check_word(word)
    end

    def get_path_error
      @status_code = "500 Internal Server Error"
      raise SystemError
      rescue => detail
      detail.backtrace.join("\n")
    end

    def get_path_start_game
      if @game.nil?
        @game = Game.new
        @status_code = "302 Found"
        "Good luck!"
      else
        @status_code = "403 Forbidden"
      end
    end

    def get_path_game(request)
      if @game.nil?
        @status_code = "200 OK"
        #not actually redirecting
        "You need to start a new game first"
      else
        @status_code = "200 OK"
        @status_code = "302 Found" if request[:verb].upcase == 'POST'
        #puts @status_code
        @game.game_turn(request[:body].to_i, request[:verb])
      end
    end
  end
end
