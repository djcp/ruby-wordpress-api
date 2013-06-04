require 'yaml'
require 'erb'
require_relative "post"
require_relative "taxonomies"
require_relative "media"
require_relative "comments"
require_relative "options"
require_relative "users"

module Rubypress

  class Client

    attr_reader :connection
    attr_accessor :port, :host, :path, :username, :password, :use_ssl, :default_post_fields

    def initialize(options = {})
      {
        :port => 80,
        :use_ssl => false,
        :host => nil,
        :path => '/xmlrpc.php',
        :username => nil,
        :password => nil,
        :default_post_fields => ['post','terms','custom_fields']
      }.merge(options).each{ |opt| self.send("#{opt[0]}=", opt[1]) }
      self.connect
      self
    end

    def connect
      @connection = XMLRPC::Client.new(self.host, self.path, self.port,nil,nil,nil,nil,self.use_ssl,nil)
    end

    def self.config
      YAML.load(ERB.new(File.read('./spec/wordpress.yml')).result)
    end

    def self.testClient
      @client = self.new(config[:wordpress_admin])
    end

    def execute(method, options)
      args = []
      options_final = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }
      options_final.deep_merge!(options).each{|option| args.push(option[1]) if !option[1].nil?}
      #connection.set_debug
      server = self.connection.call("wp.#{method}", args)
      #pp server
    end

    include Post
    include Taxonomies
    include Media
    include Comments
    include Options
    include Users


  end

end
