class Distributor
  def process_request(request_array, count)
     [output(response(count)), headers]
  end

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
end
