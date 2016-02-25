module HTTP
  module HeaderGenerator
    def generate_header(output_length, status_code)
      headers(output_length, status_code)
    end

    def headers(output_length, status_code)
      headers.insert(3, location) if status_code == '301 MOVED PERMANENTLY'
      headers = ["http/1.1 #{status_code}",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output_length}\r\n\r\n"].join("\r\n")
    end

    def location
      "Location: http://127.0.0.1:9292/game"
    end
  end
end
