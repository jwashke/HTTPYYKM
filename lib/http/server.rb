require 'socket'
tcp_server = TCPServer.new(9292)
client = tcp_server.accept
#we read request from client

puts "Ready for a request"
request_lines = []
#store all request lines in an array
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end
#when the program runs, it'll hang on that gets method call waiting for a request to come in. When it arrives it'll get read
#and stored into request_lines

puts "Got this request:"
puts request_lines.inspect
#print response
puts "Sending response."
response = "<pre>" + request_lines.join("\n") + "</pre>"
output = "<html><head></head><body>#{response}</body></html>"
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
client.puts headers
client.puts output
#close server
puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nResponse complete, exiting."
