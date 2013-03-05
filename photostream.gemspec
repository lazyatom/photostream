# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "photostream"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Adam"]
  s.date = "2013-03-05"
  s.email = "james@lazyatom.com"
  s.executables = ["photostream"]
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["README.markdown", "bin/photostream", "lib/photostream.rb"]
  s.homepage = "http://lazyatom.com"
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Makes it easier to deal with the Photo Stream via the Finder"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
