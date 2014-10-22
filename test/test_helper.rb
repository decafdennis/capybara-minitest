gem 'minitest'

require 'minitest/autorun'
require 'capybara'

unless ENV['CODECLIMATE_REPO_TOKEN'].nil?
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

Capybara.app = Proc.new do |env|
  [ 200, {'Content-Type' => 'text/html'}, ['Hello World']]
end
