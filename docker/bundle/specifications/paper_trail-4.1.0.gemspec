# -*- encoding: utf-8 -*-
# stub: paper_trail 4.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "paper_trail".freeze
  s.version = "4.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Stewart".freeze, "Ben Atkins".freeze]
  s.date = "2016-01-30"
  s.description = "Track changes to your models' data. Good for auditing or versioning.".freeze
  s.email = "batkinz@gmail.com".freeze
  s.homepage = "https://github.com/airblade/paper_trail".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Track changes to your models' data. Good for auditing or versioning.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, ["< 6.0", ">= 3.0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["< 6.0", ">= 3.0"])
      s.add_runtime_dependency(%q<request_store>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.1.1"])
      s.add_development_dependency(%q<shoulda>.freeze, ["~> 3.5"])
      s.add_development_dependency(%q<ffaker>.freeze, ["<= 1.31.0"])
      s.add_development_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.0"])
      s.add_development_dependency(%q<sinatra>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rack-test>.freeze, [">= 0.6"])
      s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.1.0"])
      s.add_development_dependency(%q<generator_spec>.freeze, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<pry-nav>.freeze, [">= 0"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<mysql2>.freeze, ["~> 0.3.20"])
      s.add_development_dependency(%q<pg>.freeze, ["~> 0.17"])
    else
      s.add_dependency(%q<activerecord>.freeze, ["< 6.0", ">= 3.0"])
      s.add_dependency(%q<activesupport>.freeze, ["< 6.0", ">= 3.0"])
      s.add_dependency(%q<request_store>.freeze, ["~> 1.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.1.1"])
      s.add_dependency(%q<shoulda>.freeze, ["~> 3.5"])
      s.add_dependency(%q<ffaker>.freeze, ["<= 1.31.0"])
      s.add_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.0"])
      s.add_dependency(%q<sinatra>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0.6"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.1.0"])
      s.add_dependency(%q<generator_spec>.freeze, [">= 0"])
      s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.2"])
      s.add_dependency(%q<pry-nav>.freeze, [">= 0"])
      s.add_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.2"])
      s.add_dependency(%q<mysql2>.freeze, ["~> 0.3.20"])
      s.add_dependency(%q<pg>.freeze, ["~> 0.17"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, ["< 6.0", ">= 3.0"])
    s.add_dependency(%q<activesupport>.freeze, ["< 6.0", ">= 3.0"])
    s.add_dependency(%q<request_store>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.1.1"])
    s.add_dependency(%q<shoulda>.freeze, ["~> 3.5"])
    s.add_dependency(%q<ffaker>.freeze, ["<= 1.31.0"])
    s.add_dependency(%q<railties>.freeze, ["< 5.0", ">= 3.0"])
    s.add_dependency(%q<sinatra>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0.6"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.1.0"])
    s.add_dependency(%q<generator_spec>.freeze, [">= 0"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.2"])
    s.add_dependency(%q<pry-nav>.freeze, [">= 0"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.2"])
    s.add_dependency(%q<mysql2>.freeze, ["~> 0.3.20"])
    s.add_dependency(%q<pg>.freeze, ["~> 0.17"])
  end
end
