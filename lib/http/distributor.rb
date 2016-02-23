class Distributor
  def process_request(request_array, count)
     [output(response(count)), headers]
  end

  #request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>",
 #"http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]

  def response(count)
    "<pre>" + ("\n") + "Hello, World!(#{count})" + "</pre>"
  end

  def output(response)
    "<html><head></head><body>#{response}</body></html>"
  end

  def headers
    ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{}\r\n\r\n"].join("\r\n")
  end

  def parsing_file(request_array)


  end
end
