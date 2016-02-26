require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'path'
require 'pry'

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
        output = @path.get_path_root(@request)
      elsif @request['Path'] == '/hello'
        output = @path.get_path_hello
      elsif @request['Path'] == '/datetime'
        output = @path.get_path_datetime
      elsif @request['Path'] == '/shutdown'
        output = @path.get_path_shutdown(@total_requests)
      elsif @request['Path'] == '/word_search'
        output = @path.get_path_word_search(request)
      elsif @request['Path'] == '/start_game'
        output = @path.get_path_start_game
      elsif @request['Path'] == '/game'
        output = @path.get_path_game(request)
      elsif @request['Path'] == '/force_error'
        output = @path.get_path_error
      else
        output = @path.get_path_not_found
      end
    end

    def generate_output(output, status_code = "200 OK")
      @output = generate_html(output)
      @header = generate_header(@output.length, status_code)
    end
  end
end
