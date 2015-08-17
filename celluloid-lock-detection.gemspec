# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "celluloid-lock-detection"
  spec.version       = "0.0.1.pre"
  spec.authors       = ["Dilum Navanjana", "Donovan Keme"]
  spec.email         = ["dilumnavanjana@gmail.com", "code@extremist.digital"]

  spec.summary       = "Lock detection for managed Celluloid actors."
  spec.description   = "Detect and announce locked tasks for threaded and fibered actors."
  spec.homepage      = "http://github.com/celluloid/celluloid-lock-detection"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|examples|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "celluloid", "~> 0.17.0"
  spec.add_runtime_dependency "celluloid-manager", ">= 0"
end
