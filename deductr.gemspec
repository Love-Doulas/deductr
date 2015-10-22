# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deductr/version"

Gem::Specification.new do |s|
  s.name        = "deductr"
  s.version     = Deductr::VERSION
  s.authors     = ["Darren Hicks"]
  s.email       = ["darren.hicks@gmail.com"]
  s.homepage    = "https://github.com/icentris/deductr"
  s.summary     = "A simple API to work with the Deductr API"
  s.description = "A simple API to work with the Deductr API"

  # s.rubyforge_project = "linkser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Gem dependencies
  #
  s.add_runtime_dependency('httparty')
  s.add_runtime_dependency('hashie')

  # Specs
  s.add_development_dependency('rspec', '>= 2.14.1')
end
