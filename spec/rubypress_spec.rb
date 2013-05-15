require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rubypress" do

  it '#initialize' do
   init_wp_admin_connection.class.should == Rubypress::Client
  end

  it '#getOptions' do
    VCR.use_cassette("getOptions", :record => :new_episodes) do
      init_wp_admin_connection.class.should == Rubypress::Client
      init_wp_admin_connection.connection.class.should == XMLRPC::Client
      init_wp_admin_connection.getOptions.class.should == Hash
      expect { init_wp_invalid_connection.getOptions }.to raise_error
    end
  end

  it '#getPosts #getPost' do
    VCR.use_cassette("getPosts", :record => :new_episodes) do
      client = init_wp_admin_connection
      posts = client.getPosts(:number => 1)
      posts.class.should == Array

      id = posts[0]["post_id"]
      client.getPost(:post_id => id).class.should == Hash
    end
  end

  it '#newPost #getUsersBlogs' do
    VCR.use_cassette("getUsersBlogs", :record => :new_episodes) do
      client = init_wp_admin_connection
      user_blogs = client.getUsersBlogs
      blog_id = user_blogs[0]["blogid"]
      init_wp_admin_connection.newPost(:blog_id => blog_id, :content => { :post_title => "Test post", :post_content => "This a great test.", :post_type => "post"}).class.should == String
    end
  end

end
