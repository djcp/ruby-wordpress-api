require_relative 'spec_helper'

describe "#taxonomies" do

  let(:term){ {:name => "Geraffes", :taxonomy => "category"} }
  let(:edited_term){ {:name => "gazelles", :taxonomy => "category"} }

  it "#newTerm" do
    VCR.use_cassette("newTerm") do
      TERM_ID = CLIENT.newTerm({:content => term})
      TERM_ID.should =~ STRING_NUMBER_REGEX
    end
  end 

  it "#getTaxonomy" do
    VCR.use_cassette("getTaxonomy") do
      CLIENT.getTaxonomy.should include("label" => "Categories")
    end
  end

  it "#getTaxonomies" do
    VCR.use_cassette("getTaxonomies") do
      CLIENT.getTaxonomies[0].should include("name"=>"category")
    end
  end

  it "#getTerm" do
    VCR.use_cassette("getTerm") do
      CLIENT.getTerm({:term_id => 1}).should include("name"=>"Uncategorized")
    end
  end  

  it "#getTerms" do
    VCR.use_cassette("getTerms") do
      CLIENT.getTerms[0].should include("taxonomy"=>"category")
    end
  end 

  it "#editTerm" do
    VCR.use_cassette("editTerm") do
      CLIENT.editTerm({:term_id => TERM_ID, :content => edited_term}).should eq(true)
    end
  end 

  it "#deleteTerm" do
    VCR.use_cassette("deleteTerm") do
      CLIENT.deleteTerm({:term_id => TERM_ID, :taxonomy => "category"}).should eq(true)
    end
  end    

end