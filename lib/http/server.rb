require 'pry'
require 'socket'
class Server
  def initialize
    @count = 0
  end

  def server_start #we read request from client
    tcp_server = TCPServer.new(9292)
    client = tcp_server.accept
    loop do
      request(client)
    end
  end
    #when the program runs, it'll hang on that gets method call waiting
    #for a request to come in. When it arrives it'll get read
    #and stored into request_lines
    def request(client)   #store all request lines in array
    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
# binding.pry
    response(request_lines, client)

  end

  def response(request_lines, client)
    @count +=1
    puts "Got this request:"
    puts request_lines.inspect
    #print response
    puts "Sending response."
    response = "<pre>" + ("\n") + "Hello, World!(#{@count})" + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    # headers =
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
    #close server
    puts ["Wrote this response:", headers, output].join("\n")
    # client.close
    # puts "\nResponse complete, exiting."
  end
end

s = Server.new
s.server_start
