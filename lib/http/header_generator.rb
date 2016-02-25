module HTTP
  module HeaderGenerator
    def generate_header(output_length, status_code)
      status_code == '301 Redirect' ? redirect_header(output, status_code) : non_redirect_header(output, status_code)
    end
  end

end
