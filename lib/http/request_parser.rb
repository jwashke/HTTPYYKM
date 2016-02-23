module HTTP
  class RequestParser
    def initialize
      @raw_request = []
      @request_hash = {}
    end

    def parse_request(raw_request)
      @raw_request = raw_request
      parse_first_line
      parse_second_line
      parse_accept_line
    end

    def parse_first_line
      first_line = split_line(0)
      split_path = first_line[1].split("?")
      # param = split_path[1].split("=")
      @request_hash[:verb]     = first_line[0]
      @request_hash[:path]     = first_line[1]
      @request_hash[:protocol] = first_line[2]
      # @request_hash[:word]     = param[1]
    end

    def parse_second_line
      second_line = split_line(1)
      second_line_two = second_line[1].split(":")
      @request_hash[:host]   = second_line_two[0]
      @request_hash[:port]   = second_line_two[1]
      @request_hash[:origin] = second_line_two[0]
    end

    def parse_accept_line
      accept_line = split_line(6)
      @request_hash[:Accept] = accept_line[1]
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

    def verb
      @request_hash[:verb]
    end

    def path
      @request_hash[:path]
    end

    def protocol
      @request_hash[:protocol]
    end

    def host
      @request_hash[:host]
    end

    def port
      @request_hash[:port]
    end

    def origin
      @request_hash[:origin]
    end

    def accept
      @request_hash[:accept]
    end
  end
end
