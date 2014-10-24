if ENV['SIMPLECOV']
  require 'simplecov'
  SimpleCov.start
end

if ENV['JENKINS_URL']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start

  require 'coveralls'
  Coveralls.wear!
end
