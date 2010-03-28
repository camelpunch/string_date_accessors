# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{string_date_accessors}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Bruce"]
  s.date = %q{2010-03-28}
  s.description = %q{
      This gem is useful if you don't want to use Rails' standard date helpers and would rather
      set a text format for reading and writing dates.
    }
  s.email = %q{andrew@camelpunch.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/string_date_accessors.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/string_date_accessors_spec.rb",
     "string_date_accessors.gemspec"
  ]
  s.homepage = %q{http://github.com/camelpunch/string_date_accessors}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Get and set dates as strings on ActiveRecord-like objects}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/string_date_accessors_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

