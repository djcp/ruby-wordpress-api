require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rubypress" do

  let(:client){ Rubypress::Client.new(:host => ENV['WORDPRESS_HOST'], :port => 80, :username => ENV['WORDPRESS_USERNAME'], :password => ENV['WORDPRESS_PASSWORD'], :use_ssl => false)
 }
  let(:invalid_client){ Rubypress::Client.new(:host => ENV['WORDPRESS_HOST'], :port => 80, :username => "wrongjf3290fh0tbf34fhjvih", :password => ENV['WORDPRESS_PASSWORD'], :use_ssl => false)
 }

  describe "client" do

    it '#initialize' do
     client.class.should == Rubypress::Client
    end

  end

  it '#getOptions' do
    VCR.use_cassette("getOptions", :record => :new_episodes) do
      client.class.should == Rubypress::Client
      client.connection.class.should == XMLRPC::Client
      client.getOptions.class.should == Hash
      expect { invalid_client.getOptions }.to raise_error
    end
  end

  it '#getPosts #getPost' do
    VCR.use_cassette("getPosts", :record => :new_episodes) do
      posts = client.getPosts(:number => 1)
      posts.class.should == Array

      id = posts[0]["post_id"]
      client.getPost(:post_id => id).class.should == Hash
    end
  end

  it '#newPost #getUsersBlogs' do
    VCR.use_cassette("getUsersBlogs", :record => :new_episodes) do
      user_blogs = client.getUsersBlogs
      blog_id = user_blogs[0]["blogid"]
      client.newPost(:blog_id => blog_id, :content => { :post_title => "Test post", :post_content => "This a great test.", :post_type => "post"}).class.should == String
    end
  end

end
