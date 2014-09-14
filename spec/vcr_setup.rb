require 'vcr'

sensitive_data = [
  'WORDPRESS_HOST',
  'WORDPRESS_PATH',
  'WORDPRESS_USERNAME',
  'WORDPRESS_HTTP_PASSWORD',
  'WORDPRESS_HTTP_LOGIN',
  'WORDPRESS_HTTP_PASS',
  'WORDPRESS_HTTP_USERNAME',
  'WORDPRESS_HTTP_PASSWORD',
  'WORDPRESS_HTTP_HOST',
  'WORDPRESS_HTTP_PATH'
]

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  sensitive_data.each do |data|
    c.filter_sensitive_data("<#{data}>") do 
      CGI::escape(ENV[data]) if ENV[data]
    end
    c.filter_sensitive_data("<#{data}>") do
      ENV[data]
    end
  end
  c.default_cassette_options = { match_requests_on: [:method] }
  c.before_playback(:getUsersBlogs){|interaction|
    interaction.response.headers['Content-Length'] = 711
  }
end
