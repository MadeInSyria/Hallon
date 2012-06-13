# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'hallon/version'

Gem::Specification.new do |gem|
  gem.name     = "hallon"
  gem.summary  = %Q{Hallon allows you to write Ruby applications utilizing the official Spotify C API.}
  gem.homepage = "http://github.com/Burgestrand/Hallon"
  gem.authors  = ["Kim Burgestrand"]
  gem.email    = 'kim@burgestrand.se'
  gem.license  = 'X11 License'

  gem.files         = `git ls-files`.split("\n")
  gem.files        += `cd spec/mockspotify/libmockspotify && git ls-files src`.split("\n").map { |path| "spec/mockspotify/libmockspotify/#{path}" }
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = []
  gem.require_paths = ["lib"]

  gem.version     = Hallon::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.required_ruby_version = '>= 1.9'

  gem.add_dependency 'ref', '~> 1.0'
  gem.add_dependency 'spotify', '~> 12.0.2'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rdiscount'
end
