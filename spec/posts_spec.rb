require_relative 'spec_helper'

describe "#post" do

  let(:post){ {:post_type => "post", :post_status => "draft", :post_title => "5 Ways to Know You're Cool", :post_content => "I don't always write tests, but when I do, I use RSpec."} }

  it "#newPost" do
    VCR.use_cassette("newPost") do
      POST_ID = CLIENT.newPost({:content => post})
      POST_ID.should =~ STRING_NUMBER_REGEX
    end
  end

  it "#getPost" do
    VCR.use_cassette("getPost") do
      CLIENT.getPost({:post_id => POST_ID}).should include("post_id" => POST_ID)
    end
  end

  it "#getPosts" do
    VCR.use_cassette("getPosts") do
      CLIENT.getPosts[0].should include("post_id")
    end
  end

  it "#editPost" do
    VCR.use_cassette("editPost") do
      CLIENT.editPost({:post_id => POST_ID, :content => post}).should eq(true)
    end
  end

  it "#deletePost" do
    VCR.use_cassette("deletePost") do
      CLIENT.deletePost({:post_id => POST_ID}).should eq(true)
    end
  end

  it "#getPostType" do
    VCR.use_cassette("getPostType") do
      CLIENT.getPostType({:post_type_name => "post"}).should include("name"=>"post")
    end
  end

  it "#getPostTypes" do
    VCR.use_cassette("getPostTypes") do
      CLIENT.getPostTypes.should include("page")
    end
  end

  it "#getPostFormats" do
    VCR.use_cassette("getPostFormats") do
      CLIENT.getPostFormats.should include("image" => "Image")
    end
  end

  it "#getPostStatusList" do
    VCR.use_cassette("getPostStatusList") do
      CLIENT.getPostStatusList.should include("draft"=>"Draft")
    end
  end

end