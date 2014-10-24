unless ENV['SIMPLECOV'].nil?
  require 'simplecov'
  SimpleCov.start
end

unless ENV['CODECLIMATE_REPO_TOKEN'].nil?
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'coveralls'
Coveralls.wear! if Coveralls.will_run?
