# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "edugem/version"

Gem::Specification.new do |s|
  s.name        = "edugem"
  s.version     = Edugem::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ed Jones"]
  s.email       = ["edjones@openhistoryproject.org"]
  s.homepage    = ""
  s.summary     = %q{Someday, goodness for K12 learning and assessment. Not there yet.}
  s.description = %q{For now this offers nothing; it aims to help you focus on innovating education, not fiddling with infrastructure.}

  s.rubyforge_project = "edugem"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
