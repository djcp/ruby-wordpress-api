$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name = 'rubypress'
  s.version = '1.2.2'
  s.platform = Gem::Platform::RUBY
  s.author = 'Zach Feldman'
  s.email = ['zachfeldman@gmail.com']
  s.homepage = 'https://github.com/zachfeldman/rubypress'
  s.summary = 'Easily access WordPress installations through the WordPress XML-RPC API.'
  s.description = 'Easily access WordPress installations through the WordPress XML-RPC API. This gem exactly mirrors the functionality provided by the WordPress XML-RPC API in Ruby.'
  s.license = 'GPLv2'

  s.required_ruby_version = '>= 1.9.3'

  s.files = 'lib/rubypress.rb'
  s.files += Dir['lib/rubypress/**']

  s.add_dependency 'retryable-rb'
  s.add_dependency 'xmlrpc'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'jeweler'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'


end
