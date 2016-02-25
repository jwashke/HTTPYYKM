module HTTP
  module HTMLGenerator
    def wrap_response(response)
      "<pre>#{response}</pre>"
    end

    def generate_html(response)
      "<html><head></head><body>#{wrap_response(response)}</body></html>"
    end
  end
end
