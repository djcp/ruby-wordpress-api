$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'rubypress'
require 'tempfile'
require_relative 'vcr_setup'

RSpec.configure do |config|

end

CLIENT = Rubypress::Client.new(:host => ENV['WORDPRESS_HOST'], :port => 80, :username => ENV['WORDPRESS_USERNAME'], :password => ENV['WORDPRESS_PASSWORD'], :use_ssl => false)
STRING_NUMBER_REGEX = /^[-+]?[0-9]+$/