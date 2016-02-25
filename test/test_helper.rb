require 'simple_cov'
require_relative '../lib/http/html_generator.rb'
require_relative '../lib/http/status_codes'
require_relative '../lib/http/header_generator'
class TestHelper
  include HTTP::HTMLGenerator
  include HTTP::HeaderGenerator
  include HTTP::StatusCodes
end
