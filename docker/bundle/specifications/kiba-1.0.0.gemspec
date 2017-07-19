# -*- encoding: utf-8 -*-
# stub: kiba 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "kiba".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thibaut Barr\u{e8}re".freeze]
  s.date = "2016-12-01"
  s.description = "Lightweight ETL for Ruby".freeze
  s.email = ["thibaut.barrere@gmail.com".freeze]
  s.executables = ["kiba".freeze]
  s.files = ["bin/kiba".freeze]
  s.homepage = "http://thbar.github.io/kiba/".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Lightweight ETL for Ruby".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<awesome_print>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<awesome_print>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<awesome_print>.freeze, [">= 0"])
  end
end
