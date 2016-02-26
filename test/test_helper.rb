require 'simplecov'
SimpleCov.start

lib_folder = File.expand_path(__dir__)
$LOAD_PATH << lib_folder

require_relative '../lib/http/html_generator.rb'
require_relative '../lib/http/status_codes'
require_relative '../lib/http/header_generator'
require_relative '../lib/http/diagnostic_generator'

class TestHelper
  include HTTP::HTMLGenerator
  include HTTP::HeaderGenerator
  include HTTP::StatusCodes
  include HTTP::DiagnosticGenerator

  def hello_body
    "<html><head></head><body><pre>Hello World! (1)</pre></body></html>"
  end

  def found_word
    "<html><head></head><body><pre>Banana is a known word.</pre></body></html>"
  end

  def not_found_word
    "<html><head></head><body><pre>Branana is not a known word.</pre></body></html>"
  end

  def start_game
    "<html><head></head><body><pre>Good luck!</pre></body></html>"
  end

  def not_found_body
    "<html><head></head><body><pre>404 Not Found</pre></body></html>"
  end

  def request_hash_start_game
    { :verb=>"GET", 'Path'=>"/start_game",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_hello
    { :verb=>"GET", 'Path'=>"/hello",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_root
    { :verb=>"GET", 'Path'=>"/",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_root_post
    { :verb=>"POST", 'Path'=>"/",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_datetime
    { :verb=>"GET", 'Path'=>"/datetime",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_start_game
    { :verb=>"GET", 'Path'=>"/start_game",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_game
    { :verb=>"GET", 'Path'=>"/game",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_shutdown
    { :verb=>"GET", 'Path'=>"/shutdown",
      :protocol=>"HTTP/1.1", :host=>" 127.0.0.1",
      :port=>"9292", :origin=>" 127.0.0.1", :Accept=>"*/*" }
  end

  def request_hash_word_search
  { :verb=>"GET", 'Path'=>"/word_search", 'Word'=>nil,
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def request_hash_word_search_coffee
  { :verb=>"GET", 'Path'=>"/word_search", 'Word'=>"coffee",
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def request_hash_word_search_coffee_all_caps
  { :verb=>"GET", 'Path'=>"/word_search", 'Word'=>"COFFEE",
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def request_hash_word_search_gibberish
  { :verb=>"GET", 'Path'=>"/word_search", 'Word'=>"cfryye",
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def request_hash_force_error
  { :verb=>"GET", 'Path'=>"/force_error", 'Word'=>"cfryye",
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def request_hash_shutdown
  { :verb=>"GET", 'Path'=>"/shutdown", 'Word'=>"cfryye",
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def request_hash_incorrect_path
  { :verb=>"GET", 'Path'=>"/lolz", 'Word'=>"cfryye",
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def request_hash_incorrect_path_2
  { :verb=>"GET", 'Path'=>"/fafsafa", 'Word'=>"cfryye",
    :protocol=>"HTTP/1.1", :host=>" 127.0.0.1", :port=>"9292",
    :origin=>" 127.0.0.1", :Accept=>"*/*"}
  end

  def html_wrapper
    "<html><head></head><body><pre>Total Requests: 1</pre></body></html>"
  end

  def diagnostic_post
    ["Verb:", "Path:", "/", "Protocol:", "Host:",
     "Port:", "Origin:", "Accept:"]
  end

  def diagnostic_get
       ["Verb:", "Path:", "/hello", "Protocol:",
      "Host:", "Port:", "Origin:", "Accept:"]
  end

  def diagnostic_incomplete
      ["Verb:", "Path:", "Protocol:",
       "Host:", "Port:", "Origin:", "Accept:"]
  end

  def diagnostic_empty
    ["Verb:", "Path:", "Protocol:", "Host:",
     "Port:", "Origin:", "Accept:"]
  end
end
