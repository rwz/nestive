# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nestive/version"

Gem::Specification.new do |s|
  s.name        = "nestive"
  s.version     = Nestive::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin French"]
  s.email       = ["justin@indent.com.au"]
  s.homepage    = ""
  s.summary     = %q{A Rails plugin/gem for awesome nested templates and layouts}
  s.description = %q{A Rails plugin/gem for awesome nested templates and layouts}

  s.rubyforge_project = "nestive"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'rails', '~> 3.0'
  s.add_development_dependency 'combustion'
  s.add_development_dependency 'rspec-rails'
  
end
