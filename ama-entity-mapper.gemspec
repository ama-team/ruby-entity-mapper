# frozen_string_literal: true
# coding: utf-8

# rubocop:disable Metrics/LineLength

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/ama-entity-mapper/version'

Gem::Specification.new do |spec|
  spec.name                  = 'ama-entity-mapper'
  spec.version               = AMA::Entity::Mapper::Version::VERSION
  spec.authors               = ['AMA Team']
  spec.email                 = ['dev@amagroup.ru']

  spec.summary               = 'Converts and instantiates classes from native data structures'
  spec.description           = spec.summary
  spec.homepage              = 'https://github.com/ama-team/ruby-entity-mapper'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 2.3'

  spec.files                 = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(lib/|docs/.*\.md)})
  end
  spec.bindir                = 'exe'
  spec.executables           = []
  spec.require_paths         = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'allure-rspec', '~> 0.8.0'
  spec.add_development_dependency 'coveralls', '~> 0.8.0'
  spec.add_development_dependency 'github-pages', '>= 146'
end
