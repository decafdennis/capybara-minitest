# Must be first!
require_relative 'test_reporting'

require 'minitest/autorun'
require 'capybara'

Capybara.app = proc do
  [200, { 'Content-Type' => 'text/html' }, ['Hello World']]
end
