module HTTP
  module StatusCodes
    def ok
      "200 OK"
    end

    def found
      "302 Found"
    end

    def unauthorized
      "401 Unauthorized"
    end

    def forbidden
      "403 Forbidden"
    end

    def not_found
      "404 Not Found"
    end

    def internal_server_error
      "500 Internal Server Error"
    end
  end
end
