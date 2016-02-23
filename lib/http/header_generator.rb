module HTTP
  module HeaderGenerator
    def generate_header(output_length, status_code)
      headers = ["http/1.1 #{status_code}",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output_length}\r\n\r\n"].join("\r\n")
    end
  end
end
