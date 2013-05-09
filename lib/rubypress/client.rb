# encoding: UTF-8

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

    def get_options(options = {})
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

    def recent_posts(options = {})
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
        :default_post_fields => self.default_post_fields
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
        opts[:default_post_fields]
      )
    end

  end

end
