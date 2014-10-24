require 'test_helper'
require 'capybara/minitest/assertions'

# Tests assertions using the Hello World Rack app.
class AssertionsTest < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def test_assertions
    visit '/'
    assert_has_text page, 'Hello World'
  end

  def test_refutations
    visit '/'
    refute_has_text page, 'Bye World'
  end

  def test_capybara_failure_messages
    visit '/'

    begin
      assert_has_text page, 'Bye World'
    rescue Minitest::Assertion => e
      assert_match(/^expected\b/i, e.message)
    end
  end

  def test_custom_failure_messages
    visit '/'

    begin
      assert_has_text page, 'Bye World', 'custom'
    rescue Minitest::Assertion => e
      assert_match(/^custom\b.+expected\b/im, e.message)
    end
  end

  def test_clean_backtrace
    visit '/'

    begin
      assert_has_text page, 'Bye World'
    rescue Minitest::Assertion => e
      refute e.backtrace.any? { |item|
        item.include?('capybara/minitest/assertions')
      }
    end
  end
end
