require File.expand_path("../lib/nestive/version", __FILE__)

Gem::Specification.new do |s|
  s.name          = "nestive"
  s.version       = Nestive::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Justin French", "Pavel Pravosud"]
  s.email         = ["justin@indent.com.au", "pavel@pravosud.com"]
  s.homepage      = "https://github.com/rwz/nestive"
  s.summary       = "A Rails gem for awesome nested templates and layouts"
  s.description   = "A Rails plugin/gem for awesome nested templates and layouts"
  s.licenses      = ["MIT"]

  s.files         = Dir["README.md", "MIT-LICENSE", "lib/**/*"]
  s.require_path  = "lib"

  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency "actionview", ">= 3.0.0"
  s.add_dependency "activesupport", ">= 3.0.0"
  s.add_dependency "railties", ">= 3.0.0"
end
