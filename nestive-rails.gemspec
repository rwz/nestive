# -*- encoding: utf-8 -*-
require File.expand_path(File.join('..', 'lib', 'nestive-rails', 'version'), __FILE__)

Gem::Specification.new do |gem|
    gem.name                  = 'nestive-rails'
    gem.version               = NestiveRails::VERSION
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'A Better Nested Inheritable Layouts Plugin for Rails 5'
    gem.description           = 'A Better Nested Inheritable Layouts Plugin for Rails 5'
    gem.authors               = ['Jonas Hübotter', 'Justin French', 'Pavel Pravosud']
    gem.email                 = ['jonas.huebotter@gmail.com', 'justin@indent.com.au', 'pavel@pravosud.com']
    gem.homepage              = 'https://github.com/jonhue/nestive-rails'
    gem.license               = 'MIT'

    gem.files                 = Dir['README.md', 'CHANGELOG.md', 'LICENSE', 'lib/**/*']
    gem.require_paths         = ['lib']

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'rails', '>= 5.0'

    gem.add_development_dependency 'rspec', '~> 3.7'
    gem.add_development_dependency 'rubocop', '~> 0.52'
end
