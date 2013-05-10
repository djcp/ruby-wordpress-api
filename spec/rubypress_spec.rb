require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rubypress" do

  it 'can instantiate' do
   init_wp_admin_connection.class.should == Rubypress::Client
  end

  it 'can connect' do
    init_wp_admin_connection.class.should == Rubypress::Client
    init_wp_admin_connection.connection.class.should == XMLRPC::Client

    init_wp_admin_connection.getOptions.class.should == Hash

    expect { init_wp_invalid_connection.getOptions }.to raise_error
  end

  it 'can use getPosts and getPost' do
    client = init_wp_editor_connection
    posts = client.getPosts(:number => 1)
    posts.class.should == Array

    id = posts[0]["post_id"]
    client.getPost(:post_id => id).class.should == Hash
  end

  it 'can use newPost method (with getUsersBlogs) to create a new post' do

    client = init_wp_editor_connection
    user_blogs = client.getUsersBlogs
    blog_id = user_blogs[0]["blogid"]
    init_wp_editor_connection.newPost(:blog_id => blog_id, :content => { :post_title => "Test post", :post_content => "This a great test.", :post_type => "post"}).class.should == String
     
  end

end
