require 'test_helper'
require 'capybara/minitest/assertions/matcher'

module Capybara
  module Minitest
    module Assertions
      # Tests Capybara::Minitest::Assertions::Matcher.
      class MatcherTest < ::Minitest::Test
        def test_all_does_not_include_become_closed
          refute Matcher.all.any? { |matcher|
            matcher.name == 'become_closed'
          }
        end

        def test_does_not_recognize_become_closed
          refute Matcher.recognizes_name?('become_closed')
        end

        def test_initialize_with_unrecognized_name
          assert_raises ArgumentError do
            Matcher.new('become_closed')
          end
        end
      end
    end
  end
end
