# encoding: UTF-8

$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'xmlrpc/client'
require 'lib/rubypress'
require 'yaml'

# cl = Rubypress::Client.new(:host => 'wordpress-trunk', :path => '/xmlrpc.php', :port => 80, :username => 'admin', :password => 'foobar', :use_ssl => false)

# puts cl.recent_posts(:number => 1, :default_post_fields => ['post_title','post_author'])
