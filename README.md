Capybara::Minitest
==================

[![Gem Version](https://badge.fury.io/rb/capybara-minitest.svg)](http://badge.fury.io/rb/capybara-minitest)

If you're using `Minitest::Test` with the `Capybara::DSL` for your tests, this
gem will allow you to do:

```ruby
# With Capybara::Minitest::Assertions included
assert_has_text page, 'Squeak', 'optional message'
```

instead of:

```ruby
# Without Capybara::Minitest
assert page.has_text?('Squeak'), 'optional message'
```

The assertions are dynamically generated from Capybara's RSpec matchers. You can
optionally provide custom failure messages and the backtrace will be cleaned up
for you.

You can see the full list of assertions (and refutations) in the
[auto-generated RDoc](https://github.com/decafdennis/capybara-minitest/blob/master/lib/capybara/minitest/assertions/rdoc.rb).

## Install

```ruby
# Gemfile
gem 'capybara-minitest'
```

## Usage

```ruby
require 'capybara/minitest/assertions'

class AcceptanceTest < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions
end
```

Or, if you're using Rails:

```ruby
require 'capybara/minitest/assertions'

class AcceptanceTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Minitest::Assertions
end
```

## Example

```ruby
class RodentTest < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def test_squeak
    visit '/rodent'
    assert_has_text page, 'Squeak', 'optional message'
  end
end
```
