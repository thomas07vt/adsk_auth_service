Gem::Specification.new do |s|
  s.name        = 'adsk_oauth_service'
  s.version     = '1.0.51'
  s.summary     = "Autodesk second phase token retrieval"
  s.description = "A gem for Autodesk 2-phase authentication service."
  s.authors     = ['Linh Chau', 'John Thomas']
  s.email       = 'thomas07@vt.edu'
  s.files       = [
                    './Gemfile', './adsk_oauth_service.gemspec',
                    'lib/adsk_oauth_service.rb',
                    'lib/services/auth_service.rb',
                    'lib/utils/net_util.rb',
                  ]
  s.homepage    = 'https://github.com/thomas07vt/adsk_oauth_service'
  s.license     = 'MIT'
  s.add_runtime_dependency 'configger_service'

  s.add_development_dependency 'rspec', '~> 3.1'
end

