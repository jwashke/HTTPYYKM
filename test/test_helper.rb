require 'simplecov'
SimpleCov.start
require_relative '../lib/http/html_generator.rb'
require_relative '../lib/http/status_codes'
require_relative '../lib/http/header_generator'
require_relative '../lib/http/diagnostic_generator'
class TestHelper
  include HTTP::HTMLGenerator
  include HTTP::HeaderGenerator
  include HTTP::StatusCodes
  include HTTP::DiagnosticGenerator
end
