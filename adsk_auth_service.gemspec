Gem::Specification.new do |s|
  s.name        = 'adsk_auth_service'
  s.version     = '1.0.10'
  s.summary     = "Autodesk second phase token retrieval"
  s.description = "A gem for Autodesk 2-phase authentication service."
  s.authors     = ['Linh Chau']
  s.email       = 'chauhonglinh@gmail.com'
  s.files       = [
                    './Gemfile', './adsk_auth_service.gemspec', 
                    'lib/adsk_auth_service.rb',
                    'lib/services/auth_service.rb', 'lib/services/token_cache_service.rb',
                    'lib/utils/net_util.rb',
                    
                  ]
  s.homepage    = 'https://github.com/linhchauatl/adsk_auth_service'
  s.license     = 'MIT'
  s.add_runtime_dependency 'cache_service'

  s.add_development_dependency 'rspec', '~> 3.1'
end
