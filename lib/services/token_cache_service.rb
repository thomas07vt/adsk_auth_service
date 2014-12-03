require 'cache_service'

class TokenCacheService < CacheService
  class << self
     def get_token
      token_data = read(token_key)
      if token_data.nil?
        token_data = AuthService.oauth_token
        set_token(token_data)
      end
      token_data
    end

    def set_token(token_data)
      write(token_key, token_data, { expires_in: token_data['expires_in'].to_i })
    end

    def token_key
      "#{ConfigService.environment}_token_key"
    end
   
  end #class methods

  initialize
end