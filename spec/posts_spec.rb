describe "#post" do

  let(:post_id){ 134 }
  let(:post){ {:post_type => "post", :post_status => "draft", :post_title => "5 Ways to Know You're Cool", :post_content => "I don't always write tests, but when I do, I use RSpec."} }
  let(:post_id_to_delete){ 137 }

  it "#getPost" do
    VCR.use_cassette("getPost") do
      CLIENT.getPost({:post_id => post_id}).should include("post_id" => "134")
    end
  end

  it "#getPosts" do
    VCR.use_cassette("getPosts") do
      CLIENT.getPosts[0].should include("post_id")
    end
  end

  it "#newPost" do
    VCR.use_cassette("newPost") do
      CLIENT.newPost({:content => post}).should =~ STRING_NUMBER_REGEX
    end
  end

  it "#editPost" do
    VCR.use_cassette("editPost") do
      CLIENT.editPost({:post_id => post_id, :content => post}).should eq(true)
    end
  end

  it "#deletePost" do
    VCR.use_cassette("deletePost") do
      CLIENT.deletePost({:post_id => post_id_to_delete}).should eq(true)
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
      CLIENT.getPostStatusList.should include("standard"=>"Standard")
    end
  end

end