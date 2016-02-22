require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/server'

class ServerTest < Minitest::Test
def test_response_says_hello_world_with_number
  s = Server.new
  s.response
  assert_equal "Hello World (0)", headers
end

end
