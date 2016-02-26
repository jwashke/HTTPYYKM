require 'pry'
module HTTP
  class RequestParser

    attr_reader :raw_request, :request_hash
    def initialize
      @raw_request = []
      @request_hash = {}
    end

    def parse_request(raw_request)
      @raw_request = raw_request
      get_verb_path_protocol_and_args(raw_request.shift)
      headers_hash = parse_rest_of_request(@raw_request).to_h
      @request_hash = @request_hash.merge(headers_hash)
      @request_hash
    end

    def parse_rest_of_request(request)
      request.map {|line| line.split(': ')}
    end

    def get_verb_path_protocol_and_args(line)
      @request_hash['Verb']     = line.split[0]
      @request_hash['Path']     = line.split[1].split("?")[0]
      @request_hash['Word']     = line.split[1].split("?")[1].split("=")[1] if line.include?("?")
      @request_hash['Protocol'] = line.split[2]
    end
  end
end
