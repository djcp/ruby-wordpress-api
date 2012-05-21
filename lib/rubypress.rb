# encoding: UTF-8

module Rubypress

  class Client
    attr_reader :connection
    attr_accessor :port, :host, :path, :username, :password, :use_ssl, :default_post_fields

    def initialize(options = {})
      opts = {
        :port => 80,
        :use_ssl => true,
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
    end

    def connect
      @connection = XMLRPC::Client.new(self.host, self.path, self.port,nil,nil,nil,nil,self.use_ssl,nil)
    end

    def recent_posts(options = {})
      self.connect if self.connection.nil?
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
      puts opts.inspect
      self.connection.call(
        "wp.getPosts", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        [
          opts[:post_type], 
          opts[:post_status],
          opts[:number],
          opts[:offset],
          opts[:orderby],
          opts[:order]
        ],
        opts[:default_post_fields]
      )
    end

  end

end
