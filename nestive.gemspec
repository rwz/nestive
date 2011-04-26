# encoding: utf-8

Gem::Specification.new do |s|
  s.name = %q{nestive}
  s.version = "0.0.1.pre"
  s.date = %q{2011-04-26}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin French"]
  s.description = %q{A Rails plugin/gem for awesome nested templates and layouts}
  s.summary = %q{A Rails plugin/gem for awesome nested templates and layouts}
  s.email = %q{justin@indent.com.au}
  s.extra_rdoc_files = ["README"]
  s.files = Dir.glob("{app,lib}/**/*")
  s.homepage = %q{http://github.com/justinfrench/nestive}
  s.post_install_message = %q{}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}

  s.add_dependency(%q<rails>, ["~> 3.1.0.pre"])

end
