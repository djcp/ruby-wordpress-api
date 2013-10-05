require 'yaml'
require 'erb'
require_relative 'posts'
require_relative 'taxonomies'
require_relative 'media'
require_relative 'comments'
require_relative 'options'
require_relative 'users'

module Rubypress

  class Client

    attr_reader :connection
    attr_accessor :port, :host, :path, :username, :password, :use_ssl, :default_post_fields, :debug

    def initialize(options = {})
      {
        :port => 80,
        :use_ssl => false,
        :host => nil,
        :path => '/xmlrpc.php',
        :username => nil,
        :password => nil,
        :default_post_fields => %w(post terms custom_fields),
        :debug => false
      }.merge(options).each{ |opt| self.send("#{opt[0]}=", opt[1]) }
      self
    end

    def connection
       server = XMLRPC::Client.new(self.host, self.path, self.port,nil,nil,nil,nil,self.use_ssl,nil)
       server.http_header_extra = {'accept-encoding' => 'identity'}
       @connection = server
    end

    def self.default
      self.new(:host => ENV['WORDPRESS_HOST'], :port => 80, :username => ENV['WORDPRESS_USERNAME'], :password => ENV['WORDPRESS_PASSWORD'], :use_ssl => false)
    end

    def execute(method, options)
      args = []
      options_final = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }
      options_final.deep_merge!(options).each{|option| args.push(option[1]) if !option[1].nil?}
      if self.debug
        connection.set_debug
        server = self.connection.call("wp.#{method}", args)
        pp server
      else
        self.connection.call("wp.#{method}", args)
      end
    end

    include Posts
    include Taxonomies
    include Media
    include Comments
    include Options
    include Users


  end

end
