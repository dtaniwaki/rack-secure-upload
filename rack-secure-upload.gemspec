require File.expand_path('../lib/rack/secure_upload/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "rack-secure-upload"
  gem.version     = Rack::SecureUpload::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Daisuke Taniwaki"]
  gem.email       = ["daisuketaniwaki@gmail.com"]
  gem.homepage    = "https://github.com/dtaniwaki/rack-secure-upload"
  gem.summary     = "Upload files securely"
  gem.description = "Upload files securely"
  gem.license     = "MIT"

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'logger', '>= 1.2'
  gem.add_dependency "rack", ">= 1.1"
  gem.add_dependency "cocaine"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 3.0"
  gem.add_development_dependency "coveralls"
end
