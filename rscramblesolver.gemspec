# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rscramblesolver/version'

Gem::Specification.new do |gem|
  gem.name          = "rscramblesolver"
  gem.version       = Rscramblesolver::VERSION
  gem.authors       = ["David Wu"]
  gem.email         = ["davidcnwu@gmail.com"]
  gem.description   = %q{A word solver for scramble games}
  gem.summary       = %q{My girlfriend always beats me at word scramble games, so now it's time for payback :]}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib", "data"]

  gem.add_development_dependency('rspec')
end
