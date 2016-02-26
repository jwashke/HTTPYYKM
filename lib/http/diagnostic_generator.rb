module HTTP
  module DiagnosticGenerator
    def request_diagnostic(request)
      "Verb: #{request['Verb']}\n" +
      "Path: #{request['Path']}\n" +
      "Protocol: #{request['Protocol']}\n" +
      "Host: #{request['Host']}\n" +
      "Port: #{request['Port']}\n" +
      "Origin: #{request['Origin']}\n" +
      "Accept: #{request['Accept']}\n"
    end
  end
end
