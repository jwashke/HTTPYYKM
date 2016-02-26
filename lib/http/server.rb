$LOAD_PATH << File.join(File.dirname(__FILE__))

Thread.abort_on_exception = true

require 'socket'
require 'distributor'
require 'request_parser'

module HTTP

  attr_reader :tcp_server, :distributor

  class Server

    def server_start
      tcp_server = TCPServer.open(9292)
      distributor = Distributor.new
      loop do
        puts "Ready for a request"
        Thread.new(tcp_server.accept) do |client|
          start_new_thread(client, distributor)
        end
      end
      rescue ShutdownException
        puts "Shutting down"
    end

    def start_new_thread(client, distributor)
      request = get_request(client)
      unless request.first.include?('favicon')
        request_hash = parse_and_send_response(request, client, distributor)
        raise ShutdownException if request_hash['Path'] == '/shutdown'
      end
    end

    def parse_and_send_response(request, client, distributor)
      request_hash = RequestParser.new.parse_request(request)
      request_hash['Body'] = get_body(request_hash, client)
      header_and_response_redirect(request_hash, client, distributor)
      client.close
      request_hash
    end

    def header_and_response_redirect(request_hash, client, distributor)
      distributor.redirect_request(request_hash)
      response = distributor.output
      header = distributor.header
      send_response(client, header, response)
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

    def get_body(request_hash, client)
      return nil unless request_hash.include?('Content-Length')
      body_length = request_hash['Content-Length']
      client.read(body_length.to_i)
    end

    def stop_server
      exit
    end
  end
end

class ShutdownException < RuntimeError
end
if __FILE__==$0
  s = HTTP::Server.new
  s.server_start
end
