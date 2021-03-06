$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "just_auth_me/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "just_auth_me"
  s.version     = JustAuthMe::VERSION
  s.authors     = ["André Barbosa"]
  s.email       = ["albmail88@gmail.com"]
  s.homepage    = "https://github.com/nata79/just_auth_me"
  s.summary     = "JustAuthMe is the most tiny and simple authorization gem for ruby on rails."
  s.description = "JustAuthMe is a gem to manage authorization in the simplest way possible. Most times you just want to check if an object belongs to the current user, JustAuthMe does just that withou any configuration."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
