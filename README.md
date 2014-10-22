Capybara::Minitest
==================

[![Gem Version](https://badge.fury.io/rb/capybara-minitest.svg)](http://badge.fury.io/rb/capybara-minitest)
[![Dependency Status](https://gemnasium.com/decafdennis/capybara-minitest.svg)](https://gemnasium.com/decafdennis/capybara-minitest)
[![Build Status](https://travis-ci.org/decafdennis/capybara-minitest.svg?branch=master)](https://travis-ci.org/decafdennis/capybara-minitest)
[![Code Climate](https://codeclimate.com/github/decafdennis/capybara-minitest/badges/gpa.svg)](https://codeclimate.com/github/decafdennis/capybara-minitest)
[![Coverage Status](https://coveralls.io/repos/decafdennis/capybara-minitest/badge.png)](https://coveralls.io/r/decafdennis/capybara-minitest)
[![Inline docs](http://inch-ci.org/github/decafdennis/capybara-minitest.svg?branch=master)](http://inch-ci.org/github/decafdennis/capybara-minitest)

**Note:** the 0.9.0 and 0.9.1 gems were broken, make sure to update to 0.9.2 using `$ gem install capybara-minitest`.

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
