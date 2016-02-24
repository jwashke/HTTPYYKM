lib_folder = File.expand_path(__dir__)
$LOAD_PATH << lib_folder

require 'pry'
require 'socket'
require 'distributor'
module HTTP
  class Server

    def server_start #we read request from client
      tcp_server = TCPServer.new(9292)
      client = tcp_server.accept
      puts "Ready for a request"
      distributor = Distributor.new
      loop do
        request = []
        while line = client.gets and !line.chomp.empty?
          request << line.chomp
        end
        puts request
        distributor.parse_request(request)
        response = distributor.output
        header = distributor.header
        client.puts header
        client.puts response
        binding.pry
        break if distributor.shutdown?
      end
      client.close
    end
  end
end
s = HTTP::Server.new
s.server_start
