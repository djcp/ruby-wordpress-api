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
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getOptions", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:options] = nil
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
        :blog_id => 0,
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

    def editPost(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.editPost", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:post_id],
        opts[:content]
      )
    end

    def deletePost(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.deletePost", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:post_id]
      )
    end

    def getPostTypes(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :filter => {},
        :fields => []
      }.deep_merge(options)
      self.connection.call(
        "wp.getPostTypes", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:post_id],
        :filter => {},
        :fields => []
      )
    end

    def getPostFormats(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :filter => {}
      }.deep_merge(options)
      self.connection.call(
        "wp.getPostFormats", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:post_id],
        :filter => {}
      )
    end

    def getPostStatusList(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getPostStatusList", 
        opts[:blog_id], 
        opts[:username],
        opts[:password]
      )
    end

    def getTaxonomy(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :taxonomy => "categories"
      }.deep_merge(options)
      self.connection.call(
        "wp.getTaxonomy", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:taxonomy]
      )
    end

    def getTaxonomies(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getTaxonomies", 
        opts[:blog_id], 
        opts[:username],
        opts[:password]
      )
    end

    def getTerm(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :taxonomy => "categories"
      }.deep_merge(options)
      self.connection.call(
        "wp.getTerm", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:taxonomy],
        opts[:term_id]
      )
    end

    def getTerms(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :taxonomy => "categories"
      }.deep_merge(options)
      self.connection.call(
        "wp.getTerms", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:taxonomy],
        opts[:filter]
      )
    end

    def newTerm(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.newTerm", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:content]
      )
    end

    def editTerm(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.editTerm", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:term_id],
        opts[:content]
      )
    end

    def deleteTerm(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :taxonomy => "categories"
      }.deep_merge(options)
      self.connection.call(
        "wp.deleteTerm", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:taxonomy],
        opts[:term_id]
      )
    end

    def getMediaItem(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getMediaItem", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:attachment_id]
      )
    end

    def getMediaLibrary(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getMediaItem", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:filter]
      )
    end

    def uploadFile(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getMediaItem", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:data]
      )
    end

    def getCommentCount(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getCommentCount", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:post_id]
      )
    end

    def getComment(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getComment", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:comment_id]
      )
    end

    def getComments(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :filter => {}
      }.deep_merge(options)
      self.connection.call(
        "wp.getComments", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:filter]
      )
    end

    def newComment(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.newComment", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:post_id],
        opts[:comment]
      )
    end

    def editComment(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getCommentCount", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:comment_id],
        opts[:comment]
      )
    end

    def deleteComment(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.deleteComment", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:comment_id]
      )
    end

    def getCommentStatusList(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getCommentStatusList", 
        opts[:blog_id], 
        opts[:username],
        opts[:password]
      )
    end

    def getOptions(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :options => []
      }.deep_merge(options)
      self.connection.call(
        "wp.getOptions", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:options]
      )
    end

    def setOptions(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :options => []
      }.deep_merge(options)
      self.connection.call(
        "wp.setOptions", 
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:options]
      )
    end

    def getUsersBlogs(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getUsersBlogs",
        opts[:username],
        opts[:password]
      )
    end

    def getUser(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :fields => []
      }.deep_merge(options)
      self.connection.call(
        "wp.getUser",
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:user_id],
        opts[:fields]
      )
    end

    def getUsers(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :filter => {}
      }.deep_merge(options)
      self.connection.call(
        "wp.getUsers",
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:filter]
      )
    end

    def getProfile(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :fields => []
      }.deep_merge(options)
      self.connection.call(
        "wp.getProfile",
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:user_id],
        opts[:fields]
      )
    end

    def editProfile(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password,
        :content => {}
      }.deep_merge(options)
      self.connection.call(
        "wp.editProfile",
        opts[:blog_id], 
        opts[:username],
        opts[:password],
        opts[:content]
      )
    end

    def getAuthors(options = {})
      opts = {
        :blog_id => 0,
        :username => self.username,
        :password => self.password
      }.deep_merge(options)
      self.connection.call(
        "wp.getAuthors",
        opts[:blog_id], 
        opts[:username],
        opts[:password]
      )
    end


  end

end
