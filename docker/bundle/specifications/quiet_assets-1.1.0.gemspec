# -*- encoding: utf-8 -*-
# stub: quiet_assets 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "quiet_assets".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dmitry Karpunin".freeze, "Dmitry Vorotilin".freeze]
  s.date = "2014-12-22"
  s.description = "Quiet Assets turns off Rails asset pipeline log.".freeze
  s.email = ["koderfunk@gmail.com".freeze, "d.vorotilin@gmail.com".freeze]
  s.homepage = "http://github.com/evrone/quiet_assets".freeze
  s.licenses = ["MIT".freeze, "GPL".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Turns off Rails asset pipeline log.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<tzinfo>.freeze, [">= 0"])
    else
      s.add_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
  end
end
