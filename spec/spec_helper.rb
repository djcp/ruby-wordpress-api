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
  :port => ENV['WORDPRESS_PORT'] || 80,
  :host => ENV['WORDPRESS_HOST'],
  :username => ENV['WORDPRESS_USERNAME'],
  :password => ENV['WORDPRESS_PASSWORD'],
  :path => ENV['WORDPRESS_PATH'],
  :use_ssl => ENV['WORDPRESS_USE_SSL'] == 'true'
}

HTTP_AUTH_CLIENT_OPTS = CLIENT_OPTS.merge(
  :http_user => ENV['WORDPRESS_HTTP_LOGIN'] || 'test',
  :http_password => ENV['WORDPRESS_HTTP_PASS'] || 'test',
  :host => ENV['WORDPRESS_HTTP_HOST'],
  :port => ENV['WORDPRESS_HTTP_PORT'] || 80,
  :username => ENV['WORDPRESS_HTTP_USERNAME'],
  :password => ENV['WORDPRESS_HTTP_PASSWORD'],
  :path=> ENV['WORDPRESS_HTTP_PATH'],
  :use_ssl => ENV['WORDPRESS_HTTP_USE_SSL'] == 'true'
)


CLIENT = Rubypress::Client.new( CLIENT_OPTS )

HTTP_AUTH_CLIENT = Rubypress::Client.new( HTTP_AUTH_CLIENT_OPTS )

STRING_NUMBER_REGEX = /^[-+]?[0-9]+$/
