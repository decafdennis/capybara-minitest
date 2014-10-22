$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'capybara-minitest/version'

Gem::Specification.new do |s|
  s.name        = 'capybara-minitest'
  s.version     = CapybaraMinitest::VERSION
  s.summary     = 'Capybara assertions for minitest.'
  s.description = "Provides assertions for minitest based on Capybara's RSpec matchers."
  s.license     = 'MIT'

  s.author      = 'Dennis Stevense'
  s.homepage    = 'https://github.com/decafdennis/capybara-minitest'

  s.files = Dir['{lib,test}/**/*']
  s.test_files = Dir['test/**/*']
  s.require_paths = ['lib']

  s.add_dependency 'capybara', '~> 2.4'

  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'minitest', '~> 5.4'
  s.add_development_dependency 'rack', '~> 1.5'
end
