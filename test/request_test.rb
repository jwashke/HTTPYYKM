# require 'minitest/autorun'
# require 'minitest/pride'
# require_relative '../lib/http/request'
#
# class RequestTest < Minitest::Test
  # def test_parsing_file_outputs_correct_diagnostics_for_verb
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   assert_equal "Verb: POST", distributor.parsing_file[0]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_path_for_hello_world
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   assert_equal "Path: /hello", distributor.parsing_file(request_array)[1]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_path_for_home
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   #change the request array
  #   assert_equal "Path: /", distributor.parsing_file(request_array)[1]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_path_for_datetime
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   #change the request array
  #   assert_equal "Path: /datetime", distributor.parsing_file(request_array)[1]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_path_for_shutdown
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   #change the request array
  #   assert_equal "Path: /shutdown", distributor.parsing_file(request_array)[1]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_protocol
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   assert_equal "Protocol: HTTP/1.1", distributor.parsing_file(request_array)[2]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_host
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   assert_equal "Host: 127.0.0.1", distributor.parsing_file(request_array)[3]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_port
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   assert_equal "Port: 9292", distributor.parsing_file(request_array)[4]
  # end
  #
  # def test_parsing_file_outputs_correct_diagnostics_for_origin
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   distributor = Request.new(request_array)
  #   assert_equal "127.0.0.1", distributor.parsing_file(request_array)[5]
  # end
  #
  # def test_parsing_file_returns_complete_diagnostic
  #   skip
  #   request_array = ["<html><head></head><body><pre>\nHello, World!(0)</pre></body></html>", "http/1.1 200 ok\r\ndate: Mon, 22 Feb 2016 20:56:28 -0700\r\nserver: ruby\r\ncontent-type: text/html; charset=iso-8859-1\r\ncontent-length: \r\n\r\n"]
  #   diagnostic = "<pre>
  #                 Verb: POST
  #                 Path: /
  #                 Protocol: HTTP/1.1
  #                 Host: 127.0.0.1
  #                 Port: 9292
  #                 Origin: 127.0.0.1
  #                 Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
  #                 </pre>"
  #   distributor = Request.new(request_array)
  #   assert_equal "127.0.0.1", distributor.parsing_file
  # end
# end
