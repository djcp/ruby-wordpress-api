require_relative 'spec_helper'

describe "#media" do

  let(:file){ {:id => "", :name => "test_file.png", :bits => '"\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\n\x00\x00\x00\n\b\x03\x00\x00\x00\xBA\xEC?\x8F\x00\x00\x00\x19tEXtSoftware\x00Adobe ImageReadyq\xC9e<\x00\x00\x00\fPLTE\xAC\xAC\xAC\x87\x87\x87aaa\xFF\xFF\xFF\xF2\xB3\r\x90\x00\x00\x00\x04tRNS\xFF\xFF\xFF\x00@*\xA9\xF4\x00\x00\x004IDATx\xDAl\x8D1\x12\x00 \f\xC2\x02\xFE\xFF\xCF\x82\x0Eu0\x03\x97r\xD7\x96U\xDC\xE0\x98;\xE1@\xDB$ \xA7\xACJ\x1F\xD5h\xD0]{\x8E\xCD\x8B-\xC0\x00/\x88\x00\xDF$\xC9\x85\\\x00\x00\x00\x00IEND\xAEB`\x82"'}}
  let(:tmp) do
    tmp = Tempfile.new(file[:name])
    File.open(tmp, 'wb').write(file[:bits])
    tmp
  end


  it "#uploadFile" do
    VCR.use_cassette("uploadFile") do
      attachment = CLIENT.uploadFile({:data => file})
      ATTACHMENT_ID = attachment["id"]
      attachment.should include("file" => "test_file.png")
    end

    VCR.use_cassette("uploadFile2") do
      CLIENT.uploadFile({:filename => tmp, :data => file}).should include("file" => "test_file.png")
    end
  end     

  it "#getMediaItem" do
    VCR.use_cassette("getMediaItem") do
      CLIENT.getMediaItem({:attachment_id => ATTACHMENT_ID}).should include("title" => "test_file.png")
    end
  end

  it "#getMediaLibrary" do
    VCR.use_cassette("getMediaLibrary") do
      CLIENT.getMediaLibrary[0].should include("title" => "test_file.png")
    end
  end

end