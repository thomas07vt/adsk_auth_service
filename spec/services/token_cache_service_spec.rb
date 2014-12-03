require_relative('../rspec_helper')

describe TokenCacheService do  
  before :each do
    TokenCacheService.delete(TokenCacheService.token_key)
    allow(AuthService).to receive(:oauth_token).and_return( {'token_type'=>'Bearer', 'expires_in'=>1, 'access_token'=> 'some token'})
  end

  context 'get_token' do
    it 'returns the token_data' do
      token_data = TokenCacheService.get_token
      expect(token_data).not_to be_nil
      expect(token_data.is_a? Hash).to eql(true)
      expect(token_data['token_type']).to eql('Bearer')
      expect(token_data['expires_in']).to eql(1)
      expect(token_data['access_token']).not_to be_nil
    end

    it 'calls AuthService.oauth_token to get new token if the old token is expired' do
      token_data = TokenCacheService.get_token
      sleep 2

      expect(AuthService).to receive(:oauth_token).and_return( {'token_type'=>'Bearer', 'expires_in'=>3, 'access_token'=> 'some other token'})
      token_data_2 = TokenCacheService.get_token

      expect(token_data['access_token']).not_to eql(token_data_2['access_token'])
    end

    it 'does not call AuthService.oauth_token to get new token if the old token is not expired' do
      token_data = TokenCacheService.get_token
      token_data_2 = TokenCacheService.get_token

      expect(token_data['access_token']).to eql(token_data_2['access_token'])
    end
  end

  context 'token_key' do
    it 'returns test_token_key' do
      expect(TokenCacheService.token_key).to eql('test_token_key')
    end
  end
end