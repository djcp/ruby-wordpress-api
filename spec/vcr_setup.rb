require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data("WORDPRESS_USERNAME") do
    ENV['WORDPRESS_USERNAME']
  end
  c.filter_sensitive_data("WORDPRESS_PASSWORD") do
    ENV['WORDPRESS_PASSWORD']
  end
  c.filter_sensitive_data("WORDPRESS_HOST") do
    ENV['WORDPRESS_HOST']
  end
  c.filter_sensitive_data("WORDPRESS_HTTP_USER") do
    HTTP_AUTH_CLIENT_OPTS[ :http_user ]
  end
  c.filter_sensitive_data("WORDPRESS_HTTP_PASSWORD") do
    HTTP_AUTH_CLIENT_OPTS[ :http_password ]
  end
end
