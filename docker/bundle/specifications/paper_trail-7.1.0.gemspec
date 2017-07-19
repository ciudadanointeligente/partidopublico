# -*- encoding: utf-8 -*-
# stub: paper_trail 7.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "paper_trail".freeze
  s.version = "7.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Stewart".freeze, "Ben Atkins".freeze, "Jared Beck".freeze]
  s.date = "2017-07-09"
  s.description = "Track changes to your models, for auditing or versioning. See how a model looked\nat any stage in its lifecycle, revert it to any version, or restore it after it\nhas been destroyed.\n".freeze
  s.email = "batkinz@gmail.com".freeze
  s.homepage = "https://github.com/airblade/paper_trail".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Track changes to your models.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, ["< 5.2", ">= 4.0"])
      s.add_runtime_dependency(%q<request_store>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<ffaker>.freeze, ["~> 2.5"])
      s.add_development_dependency(%q<railties>.freeze, ["< 5.2", ">= 4.0"])
      s.add_development_dependency(%q<rack-test>.freeze, ["~> 0.6.3"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.5"])
      s.add_development_dependency(%q<generator_spec>.freeze, ["~> 0.9.3"])
      s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3.4"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.48.1"])
      s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 1.15.0"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<pg>.freeze, ["~> 0.19.0"])
      s.add_development_dependency(%q<mysql2>.freeze, ["~> 0.4.2"])
    else
      s.add_dependency(%q<activerecord>.freeze, ["< 5.2", ">= 4.0"])
      s.add_dependency(%q<request_store>.freeze, ["~> 1.1"])
      s.add_dependency(%q<appraisal>.freeze, ["~> 2.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<ffaker>.freeze, ["~> 2.5"])
      s.add_dependency(%q<railties>.freeze, ["< 5.2", ">= 4.0"])
      s.add_dependency(%q<rack-test>.freeze, ["~> 0.6.3"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.5"])
      s.add_dependency(%q<generator_spec>.freeze, ["~> 0.9.3"])
      s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.2"])
      s.add_dependency(%q<pry-byebug>.freeze, ["~> 3.4"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.48.1"])
      s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.15.0"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.2"])
      s.add_dependency(%q<pg>.freeze, ["~> 0.19.0"])
      s.add_dependency(%q<mysql2>.freeze, ["~> 0.4.2"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, ["< 5.2", ">= 4.0"])
    s.add_dependency(%q<request_store>.freeze, ["~> 1.1"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<ffaker>.freeze, ["~> 2.5"])
    s.add_dependency(%q<railties>.freeze, ["< 5.2", ">= 4.0"])
    s.add_dependency(%q<rack-test>.freeze, ["~> 0.6.3"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.5"])
    s.add_dependency(%q<generator_spec>.freeze, ["~> 0.9.3"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.2"])
    s.add_dependency(%q<pry-byebug>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.48.1"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.15.0"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.8.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.2"])
    s.add_dependency(%q<pg>.freeze, ["~> 0.19.0"])
    s.add_dependency(%q<mysql2>.freeze, ["~> 0.4.2"])
  end
end
