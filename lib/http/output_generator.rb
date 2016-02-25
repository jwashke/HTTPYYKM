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
  end
end
