require 'active_support'
require 'active_support/core_ext'
require_relative '../utils/net_util'

class AuthService
  class << self
    def load_config
      @@config ||= ConfigService.load_config('auth_keys.yml')[ConfigService.environment]
    end

    def oauth_token
       @@token_data ||= ActiveSupport::JSON.decode(
          NetUtil.call_webservices(@@config['url'], 
            'post', 
            "client_id=#{@@config['consumer_key']}&client_secret=#{@@config['consumer_secret']}&grant_type=client_credentials", 
            { headers: {'Content-Type' => 'application/x-www-form-urlencoded'} }).body
        )
     
    end

  end

  load_config
end