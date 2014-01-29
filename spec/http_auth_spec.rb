describe "#httpAuth" do

  # Monkey patch Rubypress::Client to allow access to @connection
  Rubypress::Client.class_eval do
    def rspec_connection
      @connection
    end
  end

  it "#noAuth" do
    VCR.use_cassette("httpAuthNone") do
      expect{ CLIENT.getOptions }.to raise_error(RuntimeError)
      expect( CLIENT.rspec_connection.http_last_response.code ).to eq "401"
    end
  end

  it "#validAuth" do
    VCR.use_cassette("httpAuthValid", :match_requests_on => [:method, :host, :path]) do
      HTTP_AUTH_CLIENT.getOptions
      expect( HTTP_AUTH_CLIENT.rspec_connection.http_last_response.code ).to eq "200"
    end
  end

  it "#invalidAuth" do
    VCR.use_cassette("httpAuthInvalid", :match_requests_on => [:method, :host, :path]) do
      expect{ HTTP_AUTH_CLIENT.getOptions }.to raise_error(RuntimeError)
      expect( HTTP_AUTH_CLIENT.rspec_connection.http_last_response.code ).to eq "401"
    end
  end

end
