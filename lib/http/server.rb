lib_folder = File.expand_path(__dir__)
$LOAD_PATH << lib_folder

require 'pry'
require 'socket'
require 'distributor'
require 'request_parser'
module HTTP
  class Server
    def initialize
      @distributor = Distributor.new
    end


    def server_start
      tcp_server = TCPServer.open(9292)
      client = tcp_server.accept
      distributor = Distributor.new
      puts "Ready for a request"
      loop do
        request = []
        while line = client.gets and !line.chomp.empty?
          request << line.chomp
        end
        puts "nil" if request.nil?
        puts request
        next if request.nil?
        #unless request.first.include?('favicon')
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
          break if request_hash[:path] == '/shutdown'
        #end
      end
      client.close
    end

  end
end
s = HTTP::Server.new
s.server_start
