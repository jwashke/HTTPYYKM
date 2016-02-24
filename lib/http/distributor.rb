require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'request_parser'
require_relative 'word_search'
require_relative 'game'
require 'pry'

module HTTP
  class Distributor
    include HTMLGenerator
    include HeaderGenerator

    attr_reader :header, :output, :total_requests, :request

    def initialize
      @word_search = WordSearch.new
      @request
      @header
      @total_requests = 0
      @count = 0
      @output
      @shutdown = false
    end


    def redirect_request(request_hash)
      @total_requests += 1
      @request = request_hash
      #binding.pry
      if @request[:path] == '/'
        get_path_root
      elsif @request[:path] == '/hello'
        get_path_hello
      elsif @request[:path] == '/datetime'
        get_path_datetime
      elsif @request[:path] == '/shutdown'
        get_path_shutdown
      elsif @request[:path] == '/word_search'
        get_path_word_search
      elsif @request[:path] == '/start_game'
        get_path_start_game
      elsif @request[:path] == '/game'
        get_path_game
      else
        get_path_not_found
      end
    end

    def get_path_root
      output = request_diagnostic
      generate_output(output)
    end

    def get_path_not_found
      status_code = "404 Not Found"
      generate_output(status_code, status_code)
    end

    def get_path_datetime
      output = "#{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}"
      generate_output(output)
    end

    def get_path_shutdown
      @shutdown = true
      output = "Total Requests: #{@total_requests}"
      generate_output(output)
    end

    def get_path_hello
      @count += 1
      output = "Hello World! (#{@count})"
      generate_output(output)
    end

    def get_path_word_search
      word = @request[:word]
      output = @word_search.check_word(word)
      generate_output(output)
    end

    def get_path_start_game
      @game = Game.new
      generate_output("Good luck!")
    end

    def get_path_game
      if @game.nil?
        generate_output("You need to start a new game first")
      else
        response = @game.game_turn(@request[:body].to_i, @request[:verb])
        generate_output(response)
      end
    end


    # def get_path_start_game
    #   @game_counter = 0
    #   @last_guess = nil
    #   @correct_number = rand(1..100)
    #   output = "Good Luck!"
    # end
    #
    # def get_path_game
    #   if @request[:verb] == 'POST'
    #     get_path_guessing_game
    #   else
    #     output_game_info
    #   end
    # end
    #
    # def get_path_guessing_game
    #   if @game_counter.nil?
    #     "You need to start a new game first"
    #   else
    #     @game_counter +=1
    #     guess_check(@request[:body].to_i, @correct_number)
    #   end
    # end

    def generate_output(output, status_code = "200 OK")
      @output = generate_html(output)
      @header = get_header(@output, status_code)
    end

    def get_header(output, status_code)
      output_length = output.length
      generate_header(output_length, status_code)
    end

    def request_diagnostic
      "Verb: #{@request[:verb]}\n" +
      "Path: #{@request[:path]}\n" +
      "Protocol: #{@request[:protocol]}\n" +
      "Host: #{@request[:host]}\n" +
      "Port: #{@request[:port]}\n" +
      "Origin: #{@request[:origin]}\n" +
      "Accept: #{@request[:accept]}\n"
    end

    def shutdown?
      @shutdown
    end
  end
end
