require 'simple_cov'
require_relative '../lib/http/html_generator.rb'
class TestHelper
  include HTTP::HTMLGenerator
  include HTTP::HeaderGenerator
  include HTTP::Game
end
