$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'html_generator'
require 'header_generator'
require 'path'

module HTTP
  class Distributor
    include HTMLGenerator
    include HeaderGenerator

    attr_reader :header, :total_requests, :request, :output, :path

    def initialize
      @path = Path.new
      @total_requests = 0
    end

    def redirect_request(request_hash)
      @total_requests += 1
      output = path_checker(request_hash)
      generate_output(output, @path.status_code)
    end

    def path_checker(request_hash)
      @request = request_hash
      if @request['Path'] == '/'
        @path.get_path_root(@request)
      elsif @request['Path'] == '/hello'
        @path.get_path_hello
      elsif @request['Path'] == '/datetime'
        @path.get_path_datetime
      elsif @request['Path'] == '/shutdown'
        @path.get_path_shutdown(@total_requests)
      elsif @request['Path'] == '/word_search'
        @path.get_path_word_search(request)
      elsif @request['Path'] == '/start_game'
        @path.get_path_start_game
      elsif @request['Path'] == '/game'
        @path.get_path_game(request)
      elsif @request['Path'] == '/force_error'
        @path.get_path_error
      elsif @request['Path'] == '/sleepy'
        @path.get_path_sleepy
      else
        @path.get_path_not_found
      end
    end

    def generate_output(output, status_code = "200 OK")
      @output = generate_html(output)
      @header = generate_header(@output.length, status_code)
    end
  end
end
