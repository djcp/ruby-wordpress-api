require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data("WORDPRESS_ADMIN_USER") do
    ENV['WORDPRESS_ADMIN_USER']
  end

  c.filter_sensitive_data("WORDPRESS_ADMIN_PASS") do
    ENV['WORDPRESS_ADMIN_PASS']
  end
   c.filter_sensitive_data("WORDPRESS_EDITOR_USER") do
    ENV['WORDPRESS_EDITOR_USER']
  end
  c.filter_sensitive_data("WORDPRESS_EDITOR_PASS") do
    ENV['WORDPRESS_EDITOR_PASS']
  end
  c.filter_sensitive_data("WORDPRESS_HOST") do
    ENV['WORDPRESS_HOST']
  end

  
end