# rubypress

[![Gem Version](https://badge.fury.io/rb/rubypress.png)](http://badge.fury.io/rb/rubypress)

[![Build Status](https://travis-ci.org/zachfeldman/rubypress.png)](https://travis-ci.org/zachfeldman/rubypress)

This implements the [WordPress XML RPC API](http://codex.wordpress.org/XML-RPC_WordPress_API) as released in version 3.4.

WARNING: SSL is NOT enabled by default for ease of testing for those running OS X systems without setup SSL certs. If this is important to you, checkout the options for instantiating a new client where you can set :use_ssl to true.


## Getting Started

1. Install the gem

    A. To your system
    
    `gem install rubypress`

    B. Or using Bundler

    Inside your Gemfile:

    `gem 'rubypress'`

2. Create a new client

   ```ruby
   > wp = Rubypress::Client.new(:host => "yourwordpresssite.com", :username => "yourwordpressuser@wordpress.com", :password => "yourwordpresspassword")
   ```

3. Make requests based off of the [WordPress XML RPC API Documentation](http://codex.wordpress.org/XML-RPC_WordPress_API)

    ```ruby
    > wp.getOptions

    => {"software_name"=>{"desc"=>"Software Name", "readonly"=>true, "value"=>"WordPress"}
    ```
    (just a small excerpt of actual options for the sake of the whole [brevity thing](http://3-akamai.tapcdn.com/images/thumbs/taps/2012/06/demotivational-poster-the-dude-or-the-dude-his-dudeness-el-duderino-if-you-re-not-into-the-whole-brevity-thing-3410281f-sz640x523-animate.jpg))

    ```ruby
    > wp.newPost(:blog_id => "your_blog_id", :content => { :post_status => "publish", :post_date => Time.now, :post_content => "What an awesome post", :post_title => "Woo Title" })  
    => "24"  
    ```

    (returns a post ID if post was successful)

4. Automatically retry timeouts

    When creating the client, you can optionally pass `:retry_timeouts => true` to rescue Timeout::Error and Net::ReadTimeout errors and retry the call.

To make further requests, check out the documentation - this gem should follow the exact format of the [WordPress XML RPC API](http://codex.wordpress.org/XML-RPC_WordPress_API). For even further clarification on what requests are available, take a look in the spec folder.

NOTE: If your `xmlrpc.php` is not on the host root directory, you need to 
specify it's path. For example, to connect to `myhostedwordpresssite.net/path/to/blog`:

```ruby
wp = Rubypress::Client.new(:host => "myhostedwordpresssite.net",
                           :path => "/path/to/blog/xmlrpc.php",
                           :username => "yourwordpressuser@wordpress.com",
                           :password => "yourwordpresspassword")
```

## Contributing to rubypress

Pull requests welcome.
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so we don't break it in a future version unintentionally.
* Submit a pull request

### Environment Variables

The test suite requires that the following environment variables are set:

* WORDPRESS_HOST
* WORDPRESS_USERNAME
* WORDPRESS_PASSWORD

Optionally, you can create a file in the working directory called _.env_ and add the following to it:

```
WORDPRESS_HOST=myhostedwordpresssite.net
WORDPRESS_USERNAME=yourwordpressuser@wordpress.com
WORDPRESS_PASSWORD=yourwordpresspassword
```

or use the sample-dot-env file as a base. .env will not be committed. When RSpec runs it will set the environment variables for you.

If you'd like to run the tests to test a server with plain HTTP authentication, use these environment vars:

```
WORDPRESS_HTTP_LOGIN=yourhttplogin
WORDPRESS_HTTP_PASS=yourhttppass
WORDPRESS_HTTP_USERNAME=yourwordpressusername
WORDPRESS_HTTP_PASSWORD=yourwordpresspassword
WORDPRESS_HTTP_HOST=yourhost.com
WORDPRESS_HTTP_PATH=/path/to/xmlrpc.php
```

## Credits

* Zach Feldman [@zachfeldman](http://zfeldman.com) - current maintainer, majority of codebase
* Dan Collis-Puro [@djcp](https://github.com/djcp) - original project creator

## Contributors

* Abdelkader Boudih [@seuros](https://github.com/seuros) (Removed deep_merge monkeypatch if ActiveSupport is defined, small refactors, fixed dependency issue with retry)
* Alex Dantas [@alexdantas](https://github.com/alexdantas) (README edits re: host option)
* Pacop [@pacop](https://github.com/pacop) (Added a far easier way to upload files than the default method chain.)
* David Muto [@pseudomuto](https://github.com/pseudomuto) (Added ability to use a .env file and to retry failed requests)
* Teemu Pääkkönen [@borc](https://github.com/borc) (Added HTTP authentication and tests for it)
* Brian Fletcher [@punkie](https://github.com/punkle) (Did work to try to get to 1.9.2 compat with tests, VCR issues prevented this. Now only officially support 1.9.3 and up)
## License

Licensed under the same terms as WordPress itself - GPLv2.

<!-- 
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/ed093654d3f4ac89d05750e3def34190 "githalytics.com")](http://githalytics.com/zachfeldman/rubypress) -->
