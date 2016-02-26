# require_relative 'lib/http/server'
task :default => :test

# task :start
#   @server = server.new
#   server.server_start
#
# task :stop
#   @server.stop_server

task :test do
  Dir.glob('./test/*_test.rb').each { |file| require file}
end
