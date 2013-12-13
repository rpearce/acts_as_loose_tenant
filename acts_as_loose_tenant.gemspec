$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_loose_tenant/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_loose_tenant"
  s.version     = ActsAsLooseTenant::VERSION
  s.authors     = ["Robert Pearce"]
  s.email       = ["robertwaltonpearce@gmail.com"]
  s.homepage    = "http://acts_as_loose_tenant.robertwpearce.com"
  s.summary     = "Rails multi-multi-tenancy"
  s.description = "Rails Model methods and default scope allowing a model to have many tenants through a join table."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency "acts_as_tenant", "~> 0.3.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "faker"
  s.add_development_dependency "database_cleaner"
end
