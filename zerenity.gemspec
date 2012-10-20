$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zerenity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zerenity"
  s.version     = Zerenity::VERSION
  s.authors     = ["Farrel Lifson","Daniel Lucraft", "Kacper Ciesla"]
  s.email       = ["farrel.lifson@gmail.com"]
  s.homepage    = "http://www.aimred.com/projects/zerenity"
  s.summary     = "A Zenity clone for Ruby."
  s.description = ""

  s.files = Dir["{lib,examples}/**/*"] + ["Rakefile", "README.rdoc", "CHANGELOG.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "gtk2"
  s.add_development_dependency "rcov"
  s.add_development_dependency "rake"
end
