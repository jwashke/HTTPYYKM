require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'request_parser'
require_relative 'word_search'
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

    def parse_request(raw_request)
      @total_requests += 1
      @request = RequestParser.new
      @request.parse_request(raw_request)
      puts @request.request_hash
      redirect_request
    end

    def redirect_request
      case @request.path
      when '/'
        get_path_root
      when '/hello'
        get_path_hello
      when '/datetime'
        get_path_datetime
      when '/shutdown'
        get_path_shutdown
      when '/word_search'
        get_path_word_search
      else
        get_path_404_error
      end
    end

    def get_path_root
      output = request_diagnostic
      generate_output(output)
    end

    def get_path_404_error
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
      word = @request.word
      output = @word_search.check_word(word)
      generate_output(output)
    end

    def generate_output(output, status_code = "200 OK")
      @output = generate_html(output)
      @header = get_header(@output, status_code)
    end

    def get_header(output, status_code)
      output_length = output.length
      generate_header(output_length, status_code)
    end

    def request_diagnostic
      "Verb: #{@request.verb}\n" +
      "Path: #{@request.path}\n" +
      "Protocol: #{@request.protocol}\n" +
      "Host: #{@request.host}\n" +
      "Port: #{@request.port}\n" +
      "Origin: #{@request.origin}\n" +
      "Accept: #{@request.accept}\n"
    end

    def shutdown?
      @shutdown
    end
  end
end
