require_relative 'spec_helper'

describe "#httpAuth" do

  Rubypress::Client.class_eval do
    def rspec_connection
      @connection
    end
  end

  it "#validAuth" do
    VCR.use_cassette("httpAuthValid") do
      HTTP_AUTH_CLIENT.getOptions
      expect( HTTP_AUTH_CLIENT.rspec_connection.http_last_response.code ).to eq "200"
    end
  end

  it "#invalidAuth" do
    VCR.use_cassette("httpAuthInvalid") do
      HTTP_AUTH_CLIENT.http_password = "wrongpass"
      expect{ HTTP_AUTH_CLIENT.getOptions }.to raise_error(RuntimeError)
      expect( HTTP_AUTH_CLIENT.rspec_connection.http_last_response.code ).to eq "401"
    end
  end

end