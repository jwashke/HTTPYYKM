lib_folder = File.expand_path(__dir__)
$LOAD_PATH << lib_folder

require 'pry'
require 'socket'
require 'distributor'
require 'request_parser'
module HTTP
  class Server
    def initialize
      @tcp_server = TCPServer.open(9292)
      @distributor = Distributor.new
    end


    def server_start
      distributor = Distributor.new
      loop do
        puts "Ready for a request"
        Thread.new(@tcp_server.accept) do |client|
          start_new_thread(client, distributor)
        end
      end
    end

    def start_new_thread(client, distributor)
      request = get_request(client)
      unless request.first.include?('favicon')
        request_hash = RequestParser.new.parse_request(request)
        request_hash[:body] = get_body(request, client)
        distributor.redirect_request(request_hash)
        response = distributor.output
        header = distributor.header
        send_response(client, header, response)
        client.close
      end
      shutdown_server if request_hash[:path] == '/shutdown'
    end

    def send_response(client, header, response)
      client.puts header
      client.puts response
    end

    def get_request(client)
      request = []
      while line = client.gets and !line.chomp.empty? do
        request << line.chomp
      end
      request
    end

    def get_body(request, client)
      return nil unless request.join.include?('Content-Length:')
      body_length = request[1].split[1]
      client.read(body_length.to_i)
    end

    def shutdown_server
      puts "Shutting down"
      exit
    end
  end
end

s = HTTP::Server.new
s.server_start
