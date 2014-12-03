### adsk_auth_service

[![Gem Version](https://badge.fury.io/rb/adsk_auth_service.svg)](http://badge.fury.io/rb/adsk_auth_service)

This is [**Ruby**](https://www.ruby-lang.org/) gem that is used to get second phase api token in Autodesk 2-phase authentication.<br/>

**If you use [**Autodesk Development Portal**](https://developer.autodesk.com/), you must have Consumer Key and Consumer Secret**.<br/>

In your application, there must be a directory called **conf** or **config** (either of them is good).<br/>
Modify the file [**conf/auth_keys.example.yml**](https://github.com/linhchauatl/adsk_auth_service/blob/master/conf/auth_keys.example.yml) to create a file called **conf/auth_keys.yml** (or **config/auth_keys.yml**) and put your keys in there.<br/>

In the **Gemfile** of your application, write:<br/>
```
gem 'adsk_auth_service'
```

Then run `bundle`

<br/>
Or you can build the gem locally:<br/>
```
git clone https://github.com/linhchauatl/adsk_auth_service.git

cd adsk_auth_service

gem build adsk_auth_service.gemspec

gem install adsk_auth_service-<VERSION>.gem
```

In your code:
```
require 'adsk_auth_service'
```

In order to get the authentication token, call:<br/>
```
AuthService.oauth_token
```
<br/>
Test from **irb**:<br/>
Inside **irb**, type the command `require 'adsk_auth_service'`<br/>
Then you can use `AuthService.oauth_token` within **irb**.<br/>

**AuthService.oauth_token** calls the API server all the time to get the token. Each token will be expired around 30 minutes - 1 hour.<br/>
You should consider about caching the token to reuse within expiration limit, instead of calling **AuthService.oauth_token** everytime when you need a token.<br/>

### Built-in cache support (Optional - you don't have to care, if you don't want to use cache)
This gem comes with built-in [**memcached**](http://memcached.org/)  and [**Zookeeper**](http://zookeeper.apache.org) support.
Please see the gem [**CacheService**](https://github.com/linhchauatl/cache_service) to see how to configure your zookeeper or your memcached to be used with TokenCacheService service.

Then within your code, you can call:
```
TokenCacheService.get_token
```
[**TokenCacheService**](https://github.com/linhchauatl/adsk_auth_service/blob/master/lib/services/token_cache_service.rb) automatically handles caching token and token expiration.

The file **cache_config.yml** must be put in the directory **conf** or **config** of your own application to take effect.

