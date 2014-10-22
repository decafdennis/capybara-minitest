require 'capybara/rspec/matchers'

module Capybara
  module Minitest
    module Assertions
      # Represents one of the Capybara RSpec matchers.
      class Matcher
        include Capybara::RSpecMatchers

        # Returns an array of matchers representing the recognized Capybara
        # RSpec matchers.
        def self.all
          Capybara::RSpecMatchers.public_instance_methods.map do |matcher_name|
            new(matcher_name) if recognizes_name?(matcher_name)
          end.compact
        end

        # Determines whether the given RSpec matcher is recognized by this
        # class.
        def self.recognizes_name?(name)
          name.to_s.match(/^have_/)
        end

        # The name of the RSpec matcher, e.g. have_text.
        attr_reader :name

        # Initializes a new matcher based on the given RSpec matcher name.
        def initialize(name)
          unless self.class.recognizes_name?(name)
            fail ArgumentError, 'Unrecognized matcher name.'
          end

          @name = name.to_s
        end

        # Returns the matcher's name in third person.
        #
        #   matcher.name              # => have_text (infinitive form)
        #   matcher.third_person_name # => has_text  (third person form)
        #
        def third_person_name
          @third_person_name ||= @name.gsub(/^have_/, 'has_')
        end

        # Returns a new Capybara RSpec matcher object for the given matcher
        # arguments. This is what would be returned by have_text('Foo'), for
        # example.
        def matcher(*args)
          send(@name, *args)
        end

        # Returns a new array of assertions for this matcher.
        def assertions
          [MatcherAssertion.new(self), MatcherRefutation.new(self)]
        end
      end

      # Represents an assertion based on a Capybara RSpec matcher.
      class MatcherAssertion
        # The matcher this assertion is based on.
        attr_reader :matcher

        # Initializes a new assertion with the given matcher.
        def initialize(matcher)
          @matcher = matcher
        end

        # The name of the assertion.
        #
        #   assertion.matcher.name # => have_text
        #   assertion.name         # => assert_has_text
        #
        def name
          "#{self.class.name_prefix}_#{@matcher.third_person_name}"
        end

        # Executes the assertion by testing it against the matcher on the given
        # test subject and with the provided arguments. Returns an array with
        # the test result (as a boolean) and the failure message.
        def test(subject, *args)
          # Create an RSpec matcher object.
          matcher = @matcher.matcher(*args)
          # Perform the match.
          test_result = matcher.send(self.class.matcher_test_method, subject)
          # Get the failure message, which has to be done after the matching.
          failure_message = matcher.send(self.class.matcher_failure_message_method)

          [test_result, failure_message]
        end

        # The prefix for method names of this kind of assertion.
        def self.name_prefix
          'assert'
        end

        # The test method called on the RSpec matcher for this kind of
        # assertion.
        def self.matcher_test_method
          :matches?
        end

        # The failure message method called on the RSpec matcher for this kind
        # of assertion.
        def self.matcher_failure_message_method
          :failure_message
        end
      end

      # Represents a refutation based on a Capybara RSpec matcher.
      class MatcherRefutation < MatcherAssertion
        def self.name_prefix
          'refute'
        end

        def self.matcher_test_method
          :does_not_match?
        end

        def self.matcher_failure_message_method
          :failure_message_when_negated
        end
      end
    end
  end
end
