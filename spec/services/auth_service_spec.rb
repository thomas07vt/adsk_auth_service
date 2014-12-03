require_relative('../rspec_helper')

describe AuthService do
  context 'load_config' do
    it 'load config from YAML file' do
      config = AuthService.load_config
      expect(config).not_to be_nil
      expect(config.is_a? Hash).to eql(true)
    end
  end

  context 'oauth_token' do
    it 'returns auth token' do
      token_data = AuthService.oauth_token
  
      # token_data['access_token'] is the real token
      expect(token_data).not_to be_nil
      expect(token_data.is_a? Hash).to eql(true)
      expect(token_data['token_type']).not_to be_nil
      expect(token_data['expires_in']).not_to be_nil
      expect(token_data['access_token']).not_to be_nil
    end
  end

end