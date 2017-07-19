# -*- encoding: utf-8 -*-
# stub: chosen-rails 1.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "chosen-rails".freeze
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tse-Ching Ho".freeze]
  s.date = "2016-04-19"
  s.description = "Chosen is a javascript library of select box enhancer for jQuery and Protoype. This gem integrates Chosen with Rails asset pipeline for easy of use.".freeze
  s.email = ["tsechingho@gmail.com".freeze]
  s.homepage = "https://github.com/tsechingho/chosen-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Integrate Chosen javascript library with Rails asset pipeline".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_runtime_dependency(%q<coffee-rails>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<sass-rails>.freeze, [">= 3.2"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<thor>.freeze, [">= 0.14"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.0"])
      s.add_dependency(%q<coffee-rails>.freeze, [">= 3.2"])
      s.add_dependency(%q<sass-rails>.freeze, [">= 3.2"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.0"])
      s.add_dependency(%q<thor>.freeze, [">= 0.14"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.0"])
    s.add_dependency(%q<coffee-rails>.freeze, [">= 3.2"])
    s.add_dependency(%q<sass-rails>.freeze, [">= 3.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.0"])
    s.add_dependency(%q<thor>.freeze, [">= 0.14"])
  end
end
