# frozen_string_literal: true

require_relative 'lib/weneedfeed/version'

Gem::Specification.new do |spec|
  spec.name          = 'weneedfeed'
  spec.version       = Weneedfeed::VERSION
  spec.authors       = ['Ryo Nakamura']
  spec.email         = ['r7kamura@gmail.com']

  spec.summary       = 'Generate feeds from URL and selectors.'
  spec.homepage      = 'https://github.com/r7kamura/weneedfeed'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'addressable'
  spec.add_dependency 'builder'
  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'marcel'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'psych', '>= 4'
  spec.add_dependency 'rack'
  spec.add_dependency 'rack-capture', '>= 0.4.0'
  spec.add_dependency 'thor'
  spec.add_dependency 'tilt'
end
