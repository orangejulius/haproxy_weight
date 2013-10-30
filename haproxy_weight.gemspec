# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'haproxy_weight/version'

Gem::Specification.new do |spec|
  spec.name          = "haproxy_weight"
  spec.version       = HaproxyWeight::VERSION
  spec.authors       = ["Julian Simioni"]
  spec.email         = ["julian.simioni@gmail.com"]
  spec.description   = "Script to change HAProxy backend server weights."
  spec.summary       = "haproxy_weight is a command line script to safely and easily change weights of servers in an HAProxy backend."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
