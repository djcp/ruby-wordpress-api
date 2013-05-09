$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'yaml'
require 'rubypress'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end

def load_config
  YAML.load_file((File.exists?('./wordpress.yml')) ? './wordpress.yml' : 'wordpress.yml.example')
end

def init_wp_admin_connection
  config = load_config
  Rubypress::Client.new(
    config[:wordpress_admin]
  )
end

def init_wp_editor_connection
  config = load_config
  Rubypress::Client.new(
    config[:wordpress_editor]
  )
end

def init_wp_invalid_connection
  config = load_config
  Rubypress::Client.new(
    config[:wordpress_invalid]
  )
end
