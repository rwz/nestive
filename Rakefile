#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rdoc/task'

require 'bundler'
Bundler::GemHelper.install_tasks


task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new

desc 'Generate documentation for the nestive plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Nestive'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end