module HTTP
  module OutputGenerator

    def request_diagnostic(request)
      "Verb: #{request[:verb]}\n" +
      "Path: #{request[:path]}\n" +
      "Protocol: #{request[:protocol]}\n" +
      "Host: #{request[:host]}\n" +
      "Port: #{request[:port]}\n" +
      "Origin: #{request[:origin]}\n" +
      "Accept: #{request[:accept]}\n"
    end

    def get_header(output, status_code)
      output_length = output.length
      generate_header(output_length, status_code)
    end
  end
end
