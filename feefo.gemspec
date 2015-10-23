# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feefo/version'

Gem::Specification.new do |spec|
  spec.name          = "feefo"
  spec.version       = Feefo::VERSION
  spec.authors       = ["Michael Noack"]
  spec.email         = ["support@travellink.com.au"]
  spec.description   = %q{Methods to fetch and show feefo reviews}
  spec.summary       = %q{Methods to fetch and shwo feefo reviews}
  spec.homepage      = 'http://github.com/sealink/feefo'

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'pry'
end
