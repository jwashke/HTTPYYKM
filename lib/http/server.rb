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
      puts "Ready for a request"
      distributor = Distributor.new
      loop do
        Thread.new(@tcp_server.accept) do |client|
          start_new_thread(client, distributor)
        end
      end
    end

    def start_new_thread(client, distributor)
      request = []
      while line = client.gets and !line.chomp.empty? do
        request << line.chomp
      end
      unless request.first.include?('favicon')
        request_hash = RequestParser.new.parse_request(request)
        if request.join.include?('Content-Length:')
          body_length = request[1].split[1]
          request_hash[:body] = client.read(body_length.to_i)
        end
        distributor.redirect_request(request_hash)
        response = distributor.output
        header = distributor.header
        client.puts header
        client.puts response
        client.close
      end
      shutdown_server if request_hash[:path] == '/shutdown'
    end

    def shutdown_server
      puts "Shutting down"
      exit
    end
  end
end



s = HTTP::Server.new
s.server_start
