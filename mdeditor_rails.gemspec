$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mdeditor_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mdeditor_rails"
  s.version     = MdeditorRails::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MdeditorRails."
  s.description = "TODO: Description of MdeditorRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"
  s.add_dependency "font-awesome-rails"
  s.add_dependency "twitter-bootstrap-rails", "~> 2.1.9"


  s.add_development_dependency "sqlite3"
end
