describe "#taxonomies" do

    let(:term){ {:name => "Geraffes", :taxonomy => "category"} }
    let(:term_id_to_edit){ 576440 }
    let(:edited_term){ {:name => "gazelles", :taxonomy => "category"} }
    let(:term_id_to_delete){ 173470052 }
    let(:term_id_to_delete_taxonomy){ "category" }
  
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

    it "#newTerm" do
      VCR.use_cassette("newTerm") do
        CLIENT.newTerm({:content => term}).should =~ STRING_NUMBER_REGEX
      end
    end 

    it "#editTerm" do
      VCR.use_cassette("editTerm") do
        CLIENT.editTerm({:term_id => term_id_to_edit, :content => edited_term}).should eq(true)
      end
    end 

    it "#deleteTerm" do
      VCR.use_cassette("deleteTerm") do
        CLIENT.deleteTerm({:term_id => term_id_to_delete, :taxonomy => term_id_to_delete_taxonomy}).should eq(true)
      end
    end    

  end