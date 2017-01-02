# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord_preload_economizer/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-preload-economizer"
  spec.version       = Activerecord::Preload::Economizer::VERSION
  spec.authors       = ["toru.yagi"]

  spec.summary       = %q{Optimize queries of ActiveRecord preload functions.}
  spec.homepage      = "https://github.com/negito6"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
