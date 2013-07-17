# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'htmltoword/version'

Gem::Specification.new do |spec|
  spec.name          = "htmltoword"
  spec.version       = Htmltoword::VERSION
  spec.authors       = ["Nicholas Frandsen"]
  spec.email         = ["nick.rowe.frandsen@gmail.com"]
  spec.description   = %q{Convert html to word document.}
  spec.summary       = %q{Thats it folks.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack"
  spec.add_dependency "nokogiri"
  spec.add_dependency "rubyzip"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
