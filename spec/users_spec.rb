describe "#users" do

  let(:edited_profile_content){ {:first_name => "Johnson"} }

  it "#getUsersBlogs" do
    #:update_content_length_header => true, :preserve_exact_body_bytes => true, :serialize_with => :json
    VCR.use_cassette("getUsersBlogs", :tag => :getUsersBlogs) do
      CLIENT.getUsersBlogs[0].should include("blogid")
    end
  end 

  it "#getUsers" do
    VCR.use_cassette("getUsers") do
      CLIENT.getUsers[0].should include("user_id")
    end
  end

  it "#getProfile" do
    VCR.use_cassette("getProfile") do
      CLIENT.getProfile.should include("user_id")
    end
  end 

  it "#editProfile" do
    VCR.use_cassette("editProfile") do
      CLIENT.editProfile({:content => edited_profile_content}).should eq(true)
    end
  end

  it "#getAuthors" do
    VCR.use_cassette("getAuthors") do
      CLIENT.getAuthors[0].should include("user_id")
    end
  end    

end