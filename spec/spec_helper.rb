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

CLIENT = Rubypress::Client.new(
  :host => ENV['WORDPRESS_HOST'],
  :port => 80,
  :username => ENV['WORDPRESS_USERNAME'],
  :password => ENV['WORDPRESS_PASSWORD'],
  :use_ssl => false
)

STRING_NUMBER_REGEX = /^[-+]?[0-9]+$/
