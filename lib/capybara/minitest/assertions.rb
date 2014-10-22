require 'capybara/minitest/assertions/matcher'
require 'capybara/minitest/assertions/rdoc'

module Capybara
  module Minitest
    module Assertions
      # Define assertions for each of the RSpec matchers that come with Capybara.
      Matcher.all.each do |matcher|
        matcher.assertions.each do |assertion|
          define_method assertion.name do |*args|
            # We typically get a minimum of 2 arguments: the test subject and some
            # test value. Sometimes that is followed by a hash of options. Assume
            # if the last argument is a string, then it's a custom message.
            custom_message = args.length > 2 && args.last.kind_of?(String) ? args.pop : nil
            test_result, failure_message = assertion.test(*args)

            begin
              assert test_result, message(custom_message) { failure_message }
            rescue Exception => e
              # Exclude ourselves from the backtrace, so that assertion failure
              # messages show the right file and line number.
              e.backtrace.reject! { |item| item.include?(__FILE__) } if e.class.name.include?('::Assertion')
              raise e
            end
          end
        end
      end
    end
  end
end