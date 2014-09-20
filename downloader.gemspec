# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'downloader/version'

Gem::Specification.new do |spec|
  spec.name          = "downloader"
  spec.version       = Downloader::VERSION
  spec.authors       = ["Aref Aslani"]
  spec.email         = ["arefaslani@gmail.com"]
  spec.summary       = %q{A downloader program for UUT download system.}
  spec.description   = %q{A downloader program that receives links through a
                          custom protocol and sends it to either a bittorrent
                          or http or ftp client.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "eventmachine", "~> 1.0"
  spec.add_runtime_dependency "sinatra", "~> 1"
  spec.add_runtime_dependency "sinatra-contrib", "~> 1.4"
  spec.add_runtime_dependency "nokogiri", "~> 1.6"
  spec.add_runtime_dependency "sqlite3", "~> 1.3"
  spec.add_runtime_dependency "sequel", "~> 4.14"
end
