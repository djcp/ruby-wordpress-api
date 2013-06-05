require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rubypress" do

  let(:string_number_regex){ /^[-+]?[0-9]+$/ }
  let(:client){ Rubypress::Client.new(:host => ENV['WORDPRESS_HOST'], :port => 80, :username => ENV['WORDPRESS_USERNAME'], :password => ENV['WORDPRESS_PASSWORD'], :use_ssl => false) }
  let(:invalid_client){ Rubypress::Client.new(:host => ENV['WORDPRESS_HOST'], :port => 80, :username => "wrongjf3290fh0tbf34fhjvih", :password => ENV['WORDPRESS_PASSWORD'], :use_ssl => false) }
  let(:post_id){ 134 }
  let(:comment_id){ 1 }
  let(:comment){ {:comment_parent => "", :content => "This is a test thing here.", :author => "John Adams", :author_url => "http://johnadamsforpresidentnow.com", :author_email => "johnadams@whitehouse.gov"} }
  let(:attachment_id){ 129 }
  let(:file){ {:id => "", :name => "test_file.png", :bits => '"\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\n\x00\x00\x00\n\b\x03\x00\x00\x00\xBA\xEC?\x8F\x00\x00\x00\x19tEXtSoftware\x00Adobe ImageReadyq\xC9e<\x00\x00\x00\fPLTE\xAC\xAC\xAC\x87\x87\x87aaa\xFF\xFF\xFF\xF2\xB3\r\x90\x00\x00\x00\x04tRNS\xFF\xFF\xFF\x00@*\xA9\xF4\x00\x00\x004IDATx\xDAl\x8D1\x12\x00 \f\xC2\x02\xFE\xFF\xCF\x82\x0Eu0\x03\x97r\xD7\x96U\xDC\xE0\x98;\xE1@\xDB$ \xA7\xACJ\x1F\xD5h\xD0]{\x8E\xCD\x8B-\xC0\x00/\x88\x00\xDF$\xC9\x85\\\x00\x00\x00\x00IEND\xAEB`\x82"'}}
  let(:options){ { "blog_tagline" => "This is a great tagline" } }
  let(:post){ {:post_type => "post", :post_status => "draft", :post_title => "5 Ways to Know You're Cool", :post_content => "I don't always write tests, but when I do, I use RSpec."} }
  let(:post_id_to_delete){ 137 }
  let(:term){ {:name => "Geraffes", :taxonomy => "category"} }
  let(:term_id_to_edit){ 576440 }
  let(:edited_term){ {:name => "gazelles", :taxonomy => "category"} }
  let(:term_id_to_delete){ 173470052 }
  let(:term_id_to_delete_taxonomy){ "category" }
  let(:edited_profile_content){ {:first_name => "Johnson"} }

  
  describe "#client" do

    it '#initialize' do
      client.class.should == Rubypress::Client
    end

    it "#execute" do
      Rubypress::Client.any_instance.stub_chain(:connection, :call){ [{"user_id"=>"46917508", "user_login"=>"johnsmith", "display_name"=>"john"}, {"user_id"=>"33333367", "user_login"=>"johnsmith", "display_name"=>"johnsmith"}] }
      expect(client.execute("wp.getAuthors", {})).to eq( [{"user_id"=>"46917508", "user_login"=>"johnsmith", "display_name"=>"john"}, {"user_id"=>"33333367", "user_login"=>"johnsmith", "display_name"=>"johnsmith"}] )
    end

  end

  describe "#comments" do

    it "#getCommentCount" do
      VCR.use_cassette("getCommentCount") do
        client.getCommentCount({:post_id => post_id}).should include("approved" => "1")
      end
    end

    it "#getComment" do
      VCR.use_cassette("getComment") do
        client.getComment({:comment_id => comment_id}).should include("comment_id" => "1")
      end
    end

    it "#getComments" do
      VCR.use_cassette("getComments") do
        client.getComments[0].should include("post_id" => post_id.to_s)
      end
    end

    it "#newComment" do
      VCR.use_cassette("newComment") do
        client.newComment({:post_id => post_id, :comment => comment}).class.should eq(Fixnum)
      end
    end

    it "#editComment" do
      VCR.use_cassette("editComment") do
        client.editComment({:comment_id => comment_id, :comment => comment}).class.should eq(TrueClass)
      end
    end

    it "#deleteComment" do
      VCR.use_cassette("deleteComment") do
        client.deleteComment({:comment_id => comment_id}).class.should eq(TrueClass)
      end
    end

    it "#getCommentStatusList" do
      VCR.use_cassette("getCommentStatusList") do
        client.getCommentStatusList.should include("hold" => "Unapproved")
      end
    end

  end

  describe "#media" do

    it "#getMediaItem" do
      VCR.use_cassette("getMediaItem") do
        client.getMediaItem({:attachment_id => attachment_id}).should include("title" => "8yI9E3I")
      end
    end

    it "#getMediaLibrary" do
      VCR.use_cassette("getMediaLibrary") do
        client.getMediaLibrary[0].should include("attachment_id"=>"129")
      end
    end

    it "#uploadFile" do
      VCR.use_cassette("uploadFile") do
        client.uploadFile({:data => file}).should include("url" => "http://cthisisatest.files.wordpress.com/2013/06/test_file.png")
      end
    end     

  end

  describe "#options" do

    it "#getOptions" do
      VCR.use_cassette("getOptions") do
        client.getOptions.should include("time_zone" => {"desc"=>"Time Zone", "readonly"=>false, "value"=>"0"})
      end
    end

    it "#setOptions" do
      VCR.use_cassette("setOptions") do
        client.setOptions({:options => options}).should include("blog_tagline" => {"desc"=>"Site Tagline", "readonly"=>false, "value"=>"This is a great tagline"})
      end
    end

  end

  describe "#post" do

    it "#getPost" do
      VCR.use_cassette("getPost") do
        client.getPost({:post_id => post_id}).should include("post_id" => "134")
      end
    end

    it "#getPosts" do
      VCR.use_cassette("getPosts") do
        client.getPosts[0].should include("post_id")
      end
    end

    it "#newPost" do
      VCR.use_cassette("newPost") do
        client.newPost({:content => post}).should =~ string_number_regex
      end
    end

    it "#editPost" do
      VCR.use_cassette("editPost") do
        client.editPost({:post_id => post_id, :content => post}).should eq(true)
      end
    end

    it "#deletePost" do
      VCR.use_cassette("deletePost") do
        client.deletePost({:post_id => post_id_to_delete}).should eq(true)
      end
    end

    it "#getPostType" do
      VCR.use_cassette("getPostType") do
        client.getPostType({:post_type_name => "post"}).should include("name"=>"post")
      end
    end

    it "#getPostTypes" do
      VCR.use_cassette("getPostTypes") do
        client.getPostTypes.should include("page")
      end
    end

    it "#getPostFormats" do
      VCR.use_cassette("getPostFormats") do
        client.getPostFormats.should include("image" => "Image")
      end
    end

    it "#getPostStatusList" do
      VCR.use_cassette("getPostStatusList") do
        client.getPostStatusList.should include("standard"=>"Standard")
      end
    end


  end

  describe "#taxonomies" do

    it "#getTaxonomy" do
      VCR.use_cassette("getTaxonomy") do
        client.getTaxonomy.should include("label" => "Categories")
      end
    end

    it "#getTaxonomies" do
      VCR.use_cassette("getTaxonomies") do
        client.getTaxonomies[0].should include("name"=>"category")
      end
    end

    it "#getTerm" do
      VCR.use_cassette("getTerm") do
        client.getTerm({:term_id => 1}).should include("name"=>"Uncategorized")
      end
    end  

    it "#getTerms" do
      VCR.use_cassette("getTerms") do
        client.getTerms[0].should include("taxonomy"=>"category")
      end
    end 

    it "#newTerm" do
      VCR.use_cassette("newTerm") do
        client.newTerm({:content => term}).should =~ string_number_regex
      end
    end 

    it "#editTerm" do
      VCR.use_cassette("editTerm") do
        client.editTerm({:term_id => term_id_to_edit, :content => edited_term}).should eq(true)
      end
    end 

    it "#deleteTerm" do
      VCR.use_cassette("deleteTerm") do
        client.deleteTerm({:term_id => term_id_to_delete, :taxonomy => term_id_to_delete_taxonomy}).should eq(true)
      end
    end    

  end

  describe "#users" do

    it "#getUsersBlogs" do
      VCR.use_cassette("getUsersBlogs") do
        client.getUsersBlogs[0].should include("blogid")
      end
    end 

    it "#getUsers" do
      VCR.use_cassette("getUsers") do
        client.getUsers[0].should include("user_id")
      end
    end

    it "#getProfile" do
      VCR.use_cassette("getProfile") do
        client.getProfile.should include("user_id")
      end
    end 

    it "#editProfile" do
      VCR.use_cassette("editProfile") do
        client.editProfile({:content => edited_profile_content}).should eq(true)
      end
    end

    it "#getAuthors" do
      VCR.use_cassette("getAuthors") do
        client.getAuthors[0].should include("user_id")
      end
    end    

  end



end
