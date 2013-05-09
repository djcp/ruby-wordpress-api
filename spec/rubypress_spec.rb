require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rubypress" do

  it 'can instantiate' do
   init_wp_admin_connection.class.should == Rubypress::Client
  end

  it 'can connect' do
    init_wp_admin_connection.class.should == Rubypress::Client
    init_wp_admin_connection.connection.class.should == XMLRPC::Client

    init_wp_editor_connection.get_options.class.should == Hash

    expect { init_wp_invalid_connection.get_options }.to raise_error
  end

  it 'can pull the latest posts' do
    init_wp_editor_connection.recent_posts(:number => 1).class.should == Array
  end

  
end
