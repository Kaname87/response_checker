
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "response_checker/version"

Gem::Specification.new do |spec|
  spec.name          = "response_checker"
  spec.version       = ResponseChecker::VERSION
  spec.authors       = ["Kaname87"]
  spec.email         = ["kaname.nakanishi87@gmail.com"]

  spec.summary       = %q{Check response of specified uri}
  spec.homepage      = ""

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'thor'
end
