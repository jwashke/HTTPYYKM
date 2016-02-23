require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/response'

class ResponseTest < Minitest::Test
def test_response_says_hello_world_with_number
  skip
  response = Response.new
  s.hello_world
  assert_equal "Hello World (0)", headers
end

end
