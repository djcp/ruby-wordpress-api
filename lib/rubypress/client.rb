require 'yaml'
require 'erb'

module Rubypress

  class Client
    attr_reader :connection
    attr_accessor :port, :host, :path, :username, :password, :use_ssl, :default_post_fields

    def initialize(options = {})
      opts = {
        :port => 80,
        :use_ssl => false,
        :host => nil,
        :path => '/xmlrpc.php',
        :username => nil,
        :password => nil,
        :default_post_fields => ['post','terms','custom_fields']
      }.merge(options)
      self.port = opts[:port]
      self.host = opts[:host]
      self.path = opts[:path]
      self.username = opts[:username]
      self.password = opts[:password]
      self.use_ssl = opts[:use_ssl]
      self.default_post_fields = opts[:default_post_fields]
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

    def getOptions(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :options => []
      }.merge(options)
      self.connection.call(
        "wp.getOptions", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:options]
      )
    end

    def getPost(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :post_type => 'post',
        :post_status => 'publish',
        :fields => self.default_post_fields
      }.merge(options)
      self.connection.call(
        "wp.getPost", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:post_id],
        opts[:fields]
      )
    end

    def getPosts(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :post_type => 'post',
        :post_status => 'publish',
        :number => 10,
        :offset => 0,
        :orderby => 'post_date',
        :order => 'asc',
        :fields => self.default_post_fields
      }.merge(options)
      self.connection.call(
        "wp.getPosts", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        {
          :post_type => opts[:post_type], 
          :post_status => opts[:post_status],
          :number => opts[:number],
          :offset => opts[:offset],
          :orderby => opts[:orderby],
          :order => opts[:order]
        },
        opts[:fields]
      )
    end

    def newPost(options = {})
      opts = {
        :username => self.username,
        :password => self.password,
        :content => {
          :post_type => "post",
          :post_status => "publish",
          :post_date => Time.now,
          :post_format => "post",
          :comment_status => "hold",
          :ping_status => "closed"
        }
      }.deep_merge(options)
      self.connection.call(
        "wp.newPost", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:content]
      )
    end

    def getUsersBlogs(options = {})
      opts = {
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getUsersBlogs",
        opts[:username],
        opts[:password]
      )
    end


  end

end
