# -*- encoding: utf-8 -*-
# stub: yaml_db 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "yaml_db".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Wiggins".freeze, "Orion Henry".freeze]
  s.date = "2016-07-10"
  s.description = "\nYamlDb is a database-independent format for dumping and restoring data.  It complements the database-independent schema format found in db/schema.rb.  The data is saved into db/data.yml.\nThis can be used as a replacement for mysqldump or pg_dump, but only for the databases typically used by Rails apps.  Users, permissions, schemas, triggers, and other advanced database features are not supported - by design.\nAny database that has an ActiveRecord adapter should work.\n".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/yamldb/yaml_db".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.6.8".freeze
  s.summary = "yaml_db allows export/import of database into/from yaml files".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, ["< 5.1", ">= 3.0"])
      s.add_runtime_dependency(%q<rake>.freeze, [">= 0.8.7"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    else
      s.add_dependency(%q<rails>.freeze, ["< 5.1", ">= 3.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0.8.7"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<rails>.freeze, ["< 5.1", ">= 3.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0.8.7"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
  end
end
