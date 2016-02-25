require_relative '../lib/http/html_generator.rb'
require_relative '../lib/http/status_codes'
class TestHelper
  include HTTP::HTMLGenerator
  include HTTP::HeaderGenerator
  include HTTP::StatusCodes
end
