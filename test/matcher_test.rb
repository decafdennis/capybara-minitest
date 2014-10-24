require 'test_helper'
require 'capybara/minitest/assertions/matcher'

# Tests Capybara::Minitest::Assertions::Matcher.
class MatcherTest < Minitest::Test
  def test_all_does_not_include_become_closed
    refute Capybara::Minitest::Assertions::Matcher.all.any? { |matcher|
      matcher.name == 'become_closed'
    }
  end

  def test_does_not_recognize_become_closed
    refute Capybara::Minitest::Assertions::Matcher.recognizes_name?('become_closed')
  end

  def test_initialize_with_unrecognized_name
    assert_raises ArgumentError do
      Capybara::Minitest::Assertions::Matcher.new('become_closed')
    end
  end
end
