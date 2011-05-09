# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "url_validator/version"

Gem::Specification.new do |s|
  s.name        = "url_validator"
  s.version     = UrlValidator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zdenko Nevrala"]
  s.email       = ["nevralaz@gmail.com"]
  s.homepage    = "http://github.com/zdenal/url_validator"
  s.summary     = %q{URL validator}
  s.description = %q{URL validator with normalize URL from different charset}

  s.rubyforge_project = "url_validator"

  s.add_development_dependency "rspec"
  s.add_development_dependency "ruby-debug19"
  s.add_development_dependency "sqlite3"
  s.add_dependency "rails", "~>3.0.1"
  s.add_dependency "addressable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

