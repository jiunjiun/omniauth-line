# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'omniauth-line/version'

Gem::Specification.new do |s|
  s.name        = 'omniauth-line'
  s.version     = OmniAuth::Line::VERSION
  s.authors     = %w[kazasiki jiunjiun]
  s.email       = ['kazasiki@gmail.com', 'quietmes@gmail.com']
  s.homepage    = 'https://github.com/jiunjiun/omniauth-line'
  s.description = 'OmniAuth strategy for Line from kazasiki/omniauth-line'
  s.summary     = s.description
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.7.2'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'json', '>= 2.5.1'
  s.add_dependency 'jwt', '~> 2.2.0'
  s.add_dependency 'omniauth-oauth2', '~>1.3'
  s.add_development_dependency 'bundler', '~> 2.0'
  s.add_development_dependency 'rubocop', '~> 1.8.1'
end
