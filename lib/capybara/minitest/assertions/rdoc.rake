require 'erb'
require 'capybara/minitest/assertions/matcher'

BASE_FILE = __FILE__.chomp('.rake')
TEMPLATE_FILE = "#{BASE_FILE}.rb.erb"
OUTPUT_FILE = "#{BASE_FILE}.rb"

module Capybara
  module Minitest
    module Assertions
      # Context for rdoc.rb.erb.
      class RDocTemplate
        extend ERB::DefMethod
        def_erb_method 'render', TEMPLATE_FILE

        def initialize
          @assertion_names = Matcher.all.map do |matcher|
            matcher.assertions.map(&:name)
          end.flatten
        end
      end
    end
  end
end

desc 'Regenerate the RDoc for the Capybara assertions.'
task OUTPUT_FILE do
  File.open(OUTPUT_FILE, 'w') do |f|
    f.write(Capybara::Minitest::Assertions::RDocTemplate.new.render)
  end
end
