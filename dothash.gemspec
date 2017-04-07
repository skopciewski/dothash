# frozen_string_literal: true

begin
  require "./lib/dothash/version"
rescue LoadError
  module Dothash; VERSION = "0"; end
end

Gem::Specification.new do |spec|
  spec.name          = "dothash"
  spec.version       = Dothash::VERSION
  spec.authors       = ["Szymon Kopciewski"]
  spec.email         = ["s.kopciewski@gmail.com"]
  spec.summary       = "Dot notation for Hash"
  spec.description   = "Dot notation for Hash"
  spec.homepage      = "https://github.com/skopciewski/dothash"
  spec.license       = "GPL-3.0"

  spec.require_paths = ["lib"]
  spec.files         = Dir.glob("{bin,lib}/**/*") + \
                       %w(Gemfile LICENSE README.md CHANGELOG.md)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter"
end
