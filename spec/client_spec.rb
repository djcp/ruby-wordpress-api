require_relative 'spec_helper'

describe "#client" do

  it '#initialize' do
    CLIENT.class.should == Rubypress::Client
  end

  it "#execute" do
    Rubypress::Client.any_instance.stub_chain(:connection, :call){ [{"user_id"=>"46917508", "user_login"=>"johnsmith", "display_name"=>"john"}, {"user_id"=>"33333367", "user_login"=>"johnsmith", "display_name"=>"johnsmith"}] }
    expect(CLIENT.execute("wp.getAuthors", {})).to eq( [{"user_id"=>"46917508", "user_login"=>"johnsmith", "display_name"=>"john"}, {"user_id"=>"33333367", "user_login"=>"johnsmith", "display_name"=>"johnsmith"}] )
  end

  it "#execute adds wp prefix to bare method name" do
    connection = CLIENT.connection
    allow(connection).to receive(:call) do |method, args|
      expect(method).to eq('wp.getAuthors')
    end
    CLIENT.execute("getAuthors", {})
  end

  it "#execute does not modify wp prefix on method name" do
    connection = CLIENT.connection
    allow(connection).to receive(:call) do |method, args|
      expect(method).to eq('wp.getAuthors')
    end
    CLIENT.execute("wp.getAuthors", {})
  end

  it "#execute does not modify method with custom prefix" do
    connection = CLIENT.connection
    allow(connection).to receive(:call) do |method, args|
      expect(method).to eq("wpx.getAuthors")
    end
    CLIENT.execute("wpx.getAuthors", {})
  end

  it '#execute only sets up retries for the current instance' do
    retryable_connection = Rubypress::Client.new(CLIENT_OPTS.merge(retry_timeouts: true)).connection
    standard_connection = Rubypress::Client.new(CLIENT_OPTS).connection

    expect(retryable_connection).to respond_to(:call_with_retry)
    expect(standard_connection).to_not respond_to(:call_with_retry)
  end

  it '#execute retries timeouts when retry_timeouts option is true' do
    client = Rubypress::Client.new(CLIENT_OPTS.merge(retry_timeouts: true))
    connection = client.connection
    client.stub(:connection).and_return(connection)

    expect(connection).to receive(:call_without_retry).twice.and_raise(Timeout::Error)
    expect { client.execute('newComment', {}) }.to raise_error(Timeout::Error)
  end

  it '#execute retries when catch broken pipe exception and retry_timeouts option is true' do
    client = Rubypress::Client.new(CLIENT_OPTS.merge(retry_timeouts: true))
    connection = client.connection
    client.stub(:connection).and_return(connection)

    expect(connection).to receive(:call_without_retry).twice.and_raise(Errno::EPIPE)
    expect { client.execute('newComment', {}) }.to raise_error(Errno::EPIPE)
  end


  it '#execute does not retry timeouts by default' do
    client = Rubypress::Client.new(CLIENT_OPTS)
    expect(client).to_not receive(:call_with_retry)
    expect { client.execute('newComment', {}) }.to raise_error(VCR::Errors::UnhandledHTTPRequestError)
  end

  it "#connection does not include cookies by default" do
    client = Rubypress::Client.new(CLIENT_OPTS)
    connection = client.connection
    expect(connection.cookie).to eq nil
  end

  it "#connection includes cookies when set" do
    client = Rubypress::Client.new(CLIENT_OPTS.merge(cookie: "foo=bar"))
    connection = client.connection
    expect(connection.cookie).to include("foo=bar")
  end

  it "#httpAuth" do
    conn = HTTP_AUTH_CLIENT.connection

    expect( conn.user ).to eq HTTP_AUTH_CLIENT_OPTS[ :http_user ]
    expect( conn.password ).to eq HTTP_AUTH_CLIENT_OPTS[ :http_password ]

    expect( conn.user.nil? ).to be false
    expect( conn.password.nil? ).to be false

  end

  it "#connection defaults the timeout to 30s" do
    client = Rubypress::Client.new(CLIENT_OPTS)
    connection = client.connection
    expect(connection.timeout).to eq 30
  end

  it "#connection timeout can be overridden" do
    client = Rubypress::Client.new(CLIENT_OPTS.merge(timeout: 60))
    connection = client.connection
    expect(connection.timeout).to eq 60
  end
end
