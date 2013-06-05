require_relative 'spec_helper'

describe "#client" do

  it '#initialize' do
    CLIENT.class.should == Rubypress::Client
  end

  it "#execute" do
    Rubypress::Client.any_instance.stub_chain(:connection, :call){ [{"user_id"=>"46917508", "user_login"=>"johnsmith", "display_name"=>"john"}, {"user_id"=>"33333367", "user_login"=>"johnsmith", "display_name"=>"johnsmith"}] }
    expect(CLIENT.execute("wp.getAuthors", {})).to eq( [{"user_id"=>"46917508", "user_login"=>"johnsmith", "display_name"=>"john"}, {"user_id"=>"33333367", "user_login"=>"johnsmith", "display_name"=>"johnsmith"}] )
  end

end