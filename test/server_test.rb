require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/http/server'

class ServerTest < Minitest::Test
  def test_server_instantiates
    server = Server.new
    server.instance_of? Server
  end
  
  def test_server_listens_on_port_9292
    skip
    server = Server.new
    assert_equal 9292 server.port
  end

end
