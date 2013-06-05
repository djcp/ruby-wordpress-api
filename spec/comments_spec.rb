describe "#comments" do

  let(:post_id){ 134 }
  let(:comment_id){ 1 }
  let(:comment){ {:comment_parent => "", :content => "This is a test thing here.", :author => "John Adams", :author_url => "http://johnadamsforpresidentnow.com", :author_email => "johnadams@whitehouse.gov"} }
  
  it "#getCommentCount" do
    VCR.use_cassette("getCommentCount") do
      CLIENT.getCommentCount({:post_id => post_id}).should include("approved" => "1")
    end
  end

  it "#getComment" do
    VCR.use_cassette("getComment") do
      CLIENT.getComment({:comment_id => comment_id}).should include("comment_id" => "1")
    end
  end

  it "#getComments" do
    VCR.use_cassette("getComments") do
      CLIENT.getComments[0].should include("post_id" => post_id.to_s)
    end
  end

  it "#newComment" do
    VCR.use_cassette("newComment") do
      CLIENT.newComment({:post_id => post_id, :comment => comment}).class.should eq(Fixnum)
    end
  end

  it "#editComment" do
    VCR.use_cassette("editComment") do
      CLIENT.editComment({:comment_id => comment_id, :comment => comment}).class.should eq(TrueClass)
    end
  end

  it "#deleteComment" do
    VCR.use_cassette("deleteComment") do
      CLIENT.deleteComment({:comment_id => comment_id}).class.should eq(TrueClass)
    end
  end

  it "#getCommentStatusList" do
    VCR.use_cassette("getCommentStatusList") do
      CLIENT.getCommentStatusList.should include("hold" => "Unapproved")
    end
  end

end