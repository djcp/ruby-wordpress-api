$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'rubypress'
require 'tempfile'
require_relative 'vcr_setup'

def load_env(filename = '.env')
  return unless File.exists?(filename)

  File.foreach(filename) do |line|
    next if line.chomp.size == 0

    setting = line.split('=')
    key = setting.shift
    ENV[key] = setting.join('').chomp
  end
end

RSpec.configure do |config|
  load_env
end

CLIENT_OPTS = {
  :port => 80,
  :host => ENV['WORDPRESS_HOST'],
  :username => ENV['WORDPRESS_USERNAME'],
  :password => ENV['WORDPRESS_PASSWORD'],
  :use_ssl => false
}

CLIENT = Rubypress::Client.new( CLIENT_OPTS )

HTTP_AUTH_CLIENT_OPTS = CLIENT_OPTS.merge(
  :http_user => ENV['WORDPRESS_HTTP_USER'] || 'test',
  :http_password => ENV['WORDPRESS_HTTP_PASSWORD'] || 'test' )

HTTP_AUTH_CLIENT = Rubypress::Client.new( HTTP_AUTH_CLIENT_OPTS )

STRING_NUMBER_REGEX = /^[-+]?[0-9]+$/
