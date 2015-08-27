require 'active_support'
require 'active_support/core_ext'
require_relative '../utils/net_util'

class AuthService
  class << self
    def load_config
      @@config ||= (ConfigService.load_config('auth_keys.yml')[ConfigService.environment] rescue {})
      @@config
    end

    def set_config(options = {})
      @@config['url']             = options['url']
      @@config['consumer_key']    = options['consumer_key']
      @@config['consumer_secret'] = options['consumer_secret']

      @@config
    end

    def oauth_token(options = {})
      url     = options['url']              || @@config['url']
      key     = options['consumer_key']     || @@config['consumer_key']
      secret  = options['consumer_secret']  || @@config['consumer_secret']

      ActiveSupport::JSON.decode(
        NetUtil.call_webservices(url,
          'post',
          "client_id=#{key}&client_secret=#{secret}&grant_type=client_credentials",
          { headers: {'Content-Type' => 'application/x-www-form-urlencoded'} }).body
      )
    end

  end

  load_config
end
