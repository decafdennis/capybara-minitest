require 'minitest/autorun'
require 'capybara'

Capybara.app = Proc.new do |env|
  [ 200, {'Content-Type' => 'text/html'}, ['Hello World']]
end
