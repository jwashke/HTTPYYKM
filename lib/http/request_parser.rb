require 'pry'
module HTTP
  class RequestParser
    def initialize
      @raw_request = []
      @request_hash = {}
    end

    def parse_request(raw_request)
      @raw_request = raw_request
      get_verb_path_protocol_and_args(raw_request.shift)
      get_host_port_and_origin(raw_request.shift)
      get_accept(raw_request[4])
      @request_hash
    end

    def get_verb_path_protocol_and_args(line)
      @request_hash[:verb]     = line.split[0]
      @request_hash[:path]     = line.split[1].split("?")[0]
      @request_hash[:word]     = line.split[1].split("?")[1].split("=")[1] if line.include?("?")
      @request_hash[:protocol] = line.split[2]
    end

    def get_host_port_and_origin(line)
      @request_hash[:host]   = line.split(":")[1]
      @request_hash[:port]   = line.split(":")[2]
      @request_hash[:origin] = line.split(":")[1]
    end

    def get_accept(line)
      @request_hash[:Accept] = line.split[1]
    end

    def split_line(index)
      @raw_request[index].split
    end

    def raw_request
      @raw_request
    end

    def request_hash
      @request_hash
    end
  end
end
