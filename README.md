# rubypress

[![Gem Version](https://badge.fury.io/rb/rubypress.png)](http://badge.fury.io/rb/rubypress)

[![Build Status](https://travis-ci.org/zachfeldman/rubypress.png)](https://travis-ci.org/zachfeldman/rubypress)

This implements the [WordPress XML RPC API](http://codex.wordpress.org/XML-RPC_WordPress_API) as released in version 3.4.

WARNING: SSL is NOT enabled by default for ease of testing for those running OS X systems without setup SSL certs. If this is important to you, checkout the options for instantiating a new client where you can set :use_ssl to true.


# Getting Started

## Installing rubypress

### System installation

    gem install rubypress

### Using Bundler

    # Add this to your Gemfile
    gem 'rubypress'

## Using rubypress

### In a script

    require 'rubypress'

## Usage Examples

### Create a new client

    wp = Rubypress::Client.new(:host => "yourwordpresssite.com",
                               :username => "yourwordpressuser@wordpress.com",
                               :password => "yourwordpresspassword")
### Automatically retry timeouts

When creating the client, you can optionally pass `:retry_timeouts => true` to rescue Timeout::Error and Net::ReadTimeout errors and retry the call.

    wp = Rubypress::Client.new(:host => "yourwordpresssite.com",
                               :username => "yourwordpressuser@wordpress.com",
                               :password => "yourwordpresspassword",
                               :retry_timeouts => true)
### Non-standard `xmlrpc.php` location

NOTE: If your `xmlrpc.php` is not on the host root directory, you need to
specify it's path. For example, to connect to `myhostedwordpresssite.net/path/to/blog`:


    wp = Rubypress::Client.new(:host => "myhostedwordpresssite.net",
                               :username => "yourwordpressuser@wordpress.com",
                               :password => "yourwordpresspassword",
                               :path => "/path/to/blog/xmlrpc.php")



## Making requests
(Based off of the [WordPress XML RPC API Documentation](http://codex.wordpress.org/XML-RPC_WordPress_API))

### Getting Options

    wp.getOptions

    # Returns a hash of options from the wp_options table
    => {"software_name"=>{"desc"=>"Software Name",
                          "readonly"=>true,
                          "value"=>"WordPress"}}

(just a small excerpt of actual options for the sake of the whole [brevity thing](http://3-akamai.tapcdn.com/images/thumbs/taps/2012/06/demotivational-poster-the-dude-or-the-dude-his-dudeness-el-duderino-if-you-re-not-into-the-whole-brevity-thing-3410281f-sz640x523-animate.jpg))

### Creating a new post

    wp.newPost( :blog_id => "your_blog_id", # 0 unless using WP Multi-Site, then use the blog id
                :content => {
                             :post_status  => "publish",
                             :post_date    => Time.now,
                             :post_content => "This is the body",
                             :post_title   => "RubyPress is the best!",
                             :post_name    => "/rubypress-is-the-best",
                             :post_author  => 1, # 1 if there is only the admin user, otherwise the user's id
                             :terms_names  => {
                                :category   => ['Category One','Category Two','Category Three'],
                                :post_tag => ['Tag One','Tag Two', 'Tag Three']
                                              }
                             }
                )  

    # Returns the newly created posts ID if successful
    => "24"  

### Using SSL to connect
Use the default SSL port of 443  

    wp = Rubypress::Client.new(:host => "myhostedwordpresssite.net",
                               :username => "yourwordpressuser@wordpress.com",
                               :password => "yourwordpresspassword",
                               :use_ssl => true)


Use a non-default ssl port of your choosing (must be setup on your server correctly)  

    wp = Rubypress::Client.new(:host => "myhostedwordpresssite.net",
                               :username => "yourwordpressuser@wordpress.com",
                               :password => "yourwordpresspassword",
                               :use_ssl => true,
                               :ssl_port => 995)

### Uploading a file

```ruby
FILENAME='myFile.png'
wp.uploadFile(:data => {
	:name => FILENAME,
	:type => MIME::Types.type_for(FILENAME).first.to_s,
	:bits => XMLRPC::Base64.new(IO.read(FILENAME))
	})
```

To make further requests, check out the documentation - this gem should follow the exact format of the [WordPress XML RPC API](http://codex.wordpress.org/XML-RPC_WordPress_API). For even further clarification on what requests are available, take a look in the spec folder.

## Contributing to rubypress

Pull requests welcome.

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so we don't break it in a future version unintentionally.
* Submit a pull request

## Testing

### Environment Variables

The test suite requires that the following environment variables are set:

* WORDPRESS_HOST
* WORDPRESS_USERNAME
* WORDPRESS_PASSWORD

Optionally, you can create a file in the working directory called _.env_ and add the following to it:


    WORDPRESS_HOST=myhostedwordpresssite.net
    WORDPRESS_PORT=80
    WORDPRESS_USE_SSL=false
    WORDPRESS_USERNAME=yourwordpressuser@wordpress.com
    WORDPRESS_PASSWORD=yourwordpresspassword


or use the sample-dot-env file as a base. .env will not be committed. When RSpec runs it will set the environment variables for you.
If you use a port other than 80, specify it with `WORDPRESS_PORT` and use `WORDPRESS_USE_SSL=true` for HTTPS servers. Be sure to set
the port to 443 for standard HTTPS servers.

If you'd like to run the tests to test a server with plain HTTP authentication, use these environment vars:


    WORDPRESS_HTTP_LOGIN=yourhttplogin
    WORDPRESS_HTTP_PASS=yourhttppass
    WORDPRESS_HTTP_USERNAME=yourwordpressusername
    WORDPRESS_HTTP_PASSWORD=yourwordpresspassword
    WORDPRESS_HTTP_HOST=yourhost.com
    WORDPRESS_HTTP_PORT=80
    WORDPRESS_HTTP_USE_SSL=false
    WORDPRESS_HTTP_PATH=/path/to/xmlrpc.php

The Basic Authentication settings also allow a custom port and whether to use SSL/HTTPS. Note that, like the host and path, these
variable names include `HTTP_` and can be set to the same or different values as needed.

## Credits

* Zach Feldman [@zachfeldman](http://zfeldman.com) - current maintainer, majority of codebase
* Dan Collis-Puro [@djcp](https://github.com/djcp) - original project creator

## Contributors

* Abdelkader Boudih [@seuros](https://github.com/seuros) (Removed deep_merge monkeypatch if ActiveSupport is defined, small refactors, fixed dependency issue with retry)
* Alex Dantas [@alexdantas](https://github.com/alexdantas) (README edits re: host option)
* Pacop [@pacop](https://github.com/pacop) (Added a far easier way to upload files than the default method chain)
* David Muto [@pseudomuto](https://github.com/pseudomuto) (Added ability to use a .env file and to retry failed requests)
* Teemu Pääkkönen [@borc](https://github.com/borc) (Added HTTP authentication and tests for it)
* Brian Fletcher [@punkie](https://github.com/punkle) (Did work to try to get to 1.9.2 compat with tests, VCR issues prevented this. Now only officially support 1.9.3 and up)
* Corey [@developercorey](https://github.com/developercorey) (Added ability to change SSL port, README updates)
* Michael [@mibamur](https://github.com/mibamur) (Patched uploadFile method)
* Rebecca Skinner [@sevenseacat](https://github.com/sevenseacat) (Cached the XMLRPC connection to save resources)
* Casey Hadden [@caseyhadden](https://github.com/caseyhadden) (Added support for cookie-based authentication schemes)
* Noah Botimer [@botimer](https://github.com/botimer) (Allowed custom prefixes on method names and tests to run against https servers on any port)
* Carlos Pérez Cerrato [@lastko](https://github.com/lastko) (Caught Errno::EPIPE: Broken pipe errors)
* Eric Gascoine [@ericgascoine](https://github.com/ericgascoine) (Fixed getPostStatusList)
* Matt Colyer [@mcoyler](https://github.com/mcolyer) (Added configurable timeouts)
* Karim Naufal [@rimkashox](https://github.com/rimkashox) (Added support for Ruby >= 2.4.0)

## License

Licensed under the same terms as WordPress itself - GPLv2.

<!--
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/ed093654d3f4ac89d05750e3def34190 "githalytics.com")](http://githalytics.com/zachfeldman/rubypress) -->
