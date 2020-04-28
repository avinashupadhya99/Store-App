# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'countupjs/version'

Gem::Specification.new do |spec|
  spec.name          = "countupjs-rails"
  spec.version       = Countupjs::Rails::VERSION
  spec.authors       = ["Richard Tan"]
  spec.email         = ["chardos@gmail.com"]
  spec.summary       = %q{This gem provides countUp.js for your rails application.}
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
