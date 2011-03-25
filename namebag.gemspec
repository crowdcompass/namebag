# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "namebag/version"

Gem::Specification.new do |s|
  s.name        = "namebag"
  s.version     = Namebag::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matthew Boeh"]
  s.email       = ["matthew.boeh@gmail.com"]
  s.homepage    = "http://github.com/mboeh/namebag"
  s.summary     = %q{A library and command line tool for managing DNS zones}
  s.description = %q{A library and command line tool for managing DNS zones. Currently has support for Amazon Route 53.}

  s.add_dependency 'thor'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
