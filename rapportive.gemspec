# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rapportive/version'

Gem::Specification.new do |spec|
  spec.name          = "rapportive"
  spec.version       = Rapportive::VERSION
  spec.authors       = ["Alfredo Solano"]
  spec.email         = ["cantorrodista@gmail.com"]
  spec.description   = %q{Automate rapportive queries}
  spec.summary       = %q{Automate rapportive queries}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "debugger", "~> 1.6.5"

  spec.add_dependency 'httpi', '~> 2.1.0'
  spec.add_dependency 'json'
  spec.add_dependency 'httpclient'
end
