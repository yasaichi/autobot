# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autobot/version'

Gem::Specification.new do |spec|
  spec.name          = "autobot"
  spec.version       = Autobot::VERSION
  spec.authors       = ["yasaichi"]
  spec.email         = ["yasaichi@users.noreply.github.com"]

  spec.summary       = "Automatic generation of Bot from conversation data on SNS"
  spec.description   = "Autobot provides a simple way to generate Bot automatically from conversation data."
  spec.homepage      = "https://github.com/yasaichi/autobot"
  spec.license       = "MIT"

  spec.files         = Dir["exe/*", "lib/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency "faraday"
  spec.add_dependency "natto", ">= 1.0.0"
  spec.add_dependency "thor", ">= 0.18.0"
  spec.add_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
