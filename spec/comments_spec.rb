require_relative 'spec_helper'

describe "#comments" do

  let(:post_id){ 1 }
  let(:comment){ {:comment_parent => "", :content => "This is a test thing here.", :author => "John Adams", :author_url => "http://johnadamsforpresidentnow.com", :author_email => "johnadams@whitehouse.gov"} }
  
  it "#newComment" do
    VCR.use_cassette("newComment") do
      COMMENT_ID = CLIENT.newComment({:post_id => post_id, :comment => comment})
      COMMENT_ID.class.should eq(Fixnum)
    end
  end

  it "#editComment" do
    VCR.use_cassette("editComment") do
      CLIENT.editComment({:comment_id => COMMENT_ID, :comment => comment}).class.should eq(TrueClass)
    end
  end

  it "#getCommentCount" do
    VCR.use_cassette("getCommentCount") do
      CLIENT.getCommentCount({:post_id => post_id}).should include("approved")
    end
  end

  it "#getComment" do
    VCR.use_cassette("getComment") do
      CLIENT.getComment({:comment_id => COMMENT_ID}).should include("content" => "This is a test thing here.")
    end
  end

  it "#getComments" do
    VCR.use_cassette("getComments") do
      CLIENT.getComments[0].should include("post_id" => post_id.to_s)
    end
  end

  it "#deleteComment" do
    VCR.use_cassette("deleteComment") do
      CLIENT.deleteComment({:comment_id => COMMENT_ID}).class.should eq(TrueClass)
    end
  end

  it "#getCommentStatusList" do
    VCR.use_cassette("getCommentStatusList") do
      CLIENT.getCommentStatusList.should include("hold" => "Unapproved")
    end
  end

end