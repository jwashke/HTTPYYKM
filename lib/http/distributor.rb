require_relative 'html_generator'
require_relative 'header_generator'
require_relative 'request_parser'
require 'pry'

module HTTP
  class Distributor
    include HTMLGenerator
    include HeaderGenerator

    attr_reader :header, :output

    def initialize
      @request
      @header
      @count = 0
      @output
    end

    def parse_request(raw_request)
      @request = RequestParser.new
      @request.parse_request(raw_request)
      puts @request.request_hash
      redirect_request
    end

    def redirect_request
      if @request.path == "/hello"
        get_path_hello
      elsif @request.path == "/"
        get_path_root
      elsif @request.path == "/datetime"
        get_path_datetime
      end
    end

    def get_path_root


    end

    def get_path_datetime
      output = "#{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}"
      status_code = "200 OK"
      generate_output(output, status_code)
    end


    def get_path_hello
      @count += 1
      output = "Hello World! (#{@count})"
      status_code = "200 OK"
      generate_output(output, status_code)
    end

    def generate_output(output, status_code)
      @output = generate_html(output)
      @header = get_header(@output, status_code)
    end

    def get_header(output, status_code)
      output_length = output.length
      generate_header(output_length, status_code)
    end
  end
end
