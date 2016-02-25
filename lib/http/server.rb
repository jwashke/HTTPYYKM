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
      tcp_server = TCPServer.new(9292)
      client = tcp_server.accept
      distributor = Distributor.new
      puts "Ready for a request"
      loop do
        request_parser = RequestParser.new
        request = []
        while line = client.gets and !line.chomp.empty?
          request << line.chomp
        end
        unless request.first.include?('favicon')
          puts request
          request_hash = request_parser.parse_request(request)
          # end
          distributor.redirect_request(request_hash)
          response = distributor.output
          header = distributor.header
          client.puts header
          client.puts response
        end
        break if request_hash[:path] == '/shutdown'
      end
      client.close
    end

  end
end
s = HTTP::Server.new
s.server_start
