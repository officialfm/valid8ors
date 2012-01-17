# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "valid8ors"
  s.version     = "0.0.3"
  s.authors     = ["Axel Vergult", "Vincent Pochet", "Ben Colon"]
  s.email       = ["axel@official.fm", "vincent@official.fm", "ben@official.fm"]
  s.homepage    = ""
  s.summary     = %q{Rails 3 awesome custom validators}
  s.description = %q{Rails 3 awesome custom validators}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("activemodel", ">= 0")
end
