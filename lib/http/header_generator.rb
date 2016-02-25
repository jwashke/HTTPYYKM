module HTTP
  module HeaderGenerator
    def generate_header(output_length, status_code)
      status_code == '301 Redirect' ? redirect_header(output, status_code) : non_redirect_header(output, status_code)
    end

    def non_redirect_header
      headers = ["http/1.1 #{status_code}",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output_length}\r\n\r\n"].join("\r\n")
    end

    def redirect_header
      headers = ["http/1.1 #{status_code}",
                "Location: 127.0.0.1:9292/game",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output_length}\r\n\r\n"].join("\r\n")
    end
  end
end
