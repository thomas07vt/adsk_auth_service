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

  context 'set_config' do
    before do
      @orig_config = AuthService.load_config
    end
    
    after(:all) do
      AuthService.set_config(@orig_config)
    end

    it 'sets the @@config["url"] property' do
      config = AuthService.set_config({ 'url' => 'http://example.com' })
      expect(config['url']).to eq('http://example.com')
    end

    it 'sets the @@config["consumer_key"] property' do
      config = AuthService.set_config({ 'consumer_key' => '12345' })
      expect(config['consumer_key']).to eq('12345')
    end

    it 'sets the @@config["consumer_secret"] property' do
      config = AuthService.set_config({ 'consumer_secret' => '54321' })
      expect(config['consumer_secret']).to eq('54321')
    end


  end

end