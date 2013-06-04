$LOAD_PATH.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name              = "rubypress"
  s.version           = "0.0.2"
  s.platform          = Gem::Platform::RUBY
  s.author            = "Daniel Collis-Puro"
  s.email             = ["djcp@thoughtbot.com"]
  s.homepage          = "https://github.com/djcp/ruby-wordpress-api"
  s.summary           = "Easily access WordPress installations."
  s.description       = "Easily push to WordPress installations through the WordPress XML-RPC API."

  s.required_ruby_version = ">= 1.9.2"

  s.files = "lib/rubypress.rb"
  s.files += Dir["lib/rubypress/**"]
  
end