# rubypress

[![Gem Version](https://badge.fury.io/rb/rubypress.png)](http://badge.fury.io/rb/rubypress)

This implements the [WordPress XML RPC API][wp-api] as released in version 3.4.

WARNING: SSL is NOT enabled by default for ease of testing for those running OS
X systems without setup SSL certs. If this is important to you, checkout the
options for instantiating a new client where you can set :use_ssl to true.

## Installation

Installing to your system:
    
    gem install rubypress

Or when using Bundler, add this to your Gemfile:

    gem 'rubypress'

## Getting Started

`rubypress` follows the exact format of the [WordPress XML RPC API][wp-api].

First, create a new client

```ruby
wp = Rubypress::Client.new(:host => "yourwordpresssite.com",
                           :username => "yourwordpressuser@wordpress.com",
                           :password => "yourwordpresspassword")
```

Then, make requests based off of the [WordPress XML RPC API Documentation][wp-api].
For example, to get info on the wordpress site:

```ruby
> wp.getOptions

=> {"software_name"=>{"desc"=>"Software Name", "readonly"=>true, "value"=>"WordPress"}, ...}
```

(just a small excerpt of actual options for the sake
 of the whole [brevity thing])
 
To make a new post:

```ruby
wp.newPost(:blog_id => "your_blog_id",
           :content => {
                :post_status => "publish",
                :post_date => Time.now,
                :post_content => "What an awesome post",
                :post_title => "Woo Title"
           })
```

(returns a post ID if post was successful)

To make further requests, check out the documentation.
For even further clarification on what requests are available, take a look
in the spec folder.

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

## Credits

* Zach Feldman [@zachfeldman](http://zfeldman.com)
* Dan Collis-Puro (dan@collispuro.com)

## Contributors

* Abdelkader Boudih [@seuros](https://github.com/seuros)

## License

Licensed under the same terms as WordPress itself - GPLv2.

[wp-api]:http://codex.wordpress.org/XML-RPC_WordPress_API
[brevity thing]:http://3-akamai.tapcdn.com/images/thumbs/taps/2012/06/demotivational-poster-the-dude-or-the-dude-his-dudeness-el-duderino-if-you-re-not-into-the-whole-brevity-thing-3410281f-sz640x523-animate.jpg

<!-- 
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/ed093654d3f4ac89d05750e3def34190 "githalytics.com")](http://githalytics.com/zachfeldman/rubypress) -->
