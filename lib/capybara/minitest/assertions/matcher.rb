require 'capybara/rspec/matchers'

module Capybara
  module Minitest
    module Assertions
      class Matcher
        include Capybara::RSpecMatchers

        # Returns an array of matchers representing the recognized Capybara RSpec
        # matchers.
        def self.all
          Capybara::RSpecMatchers.public_instance_methods.map do |matcher_name|
            new(matcher_name) if recognizes_name?(matcher_name)
          end.compact
        end

        # Determines whether the given RSpec matcher is recognized by this class.
        def self.recognizes_name?(name)
          name.to_s.match(/^have_/)
        end

        attr_reader :name

        def initialize(name)
          raise ArgumentError.new('Unrecognized matcher name.') unless self.class.recognizes_name?(name)
          @name = name.to_s
        end

        def third_person_name
          @third_person_name ||= @name.gsub(/^have_/, 'has_')
        end

        # Returns a new Capybara RSpec matcher object for the given matcher
        # arguments. This is what would be returned by have_text('Foo'), for
        # example.
        def matcher(*args)
          self.send(@name, *args)
        end

        # Returns a new array of assertions for this matcher.
        def assertions
          [
              MatcherAssertion.new(self),
              MatcherRefutation.new(self),
          ]
        end
      end

      class MatcherAssertion
        attr_reader :matcher

        def initialize(matcher)
          @matcher = matcher
        end

        def name
          "#{name_prefix}_#{@matcher.third_person_name}"
        end

        def test(subject, *args)
          # Create an RSpec matcher object.
          matcher = @matcher.matcher(*args)
          # Perform the match.
          test_result = matcher.send(matcher_test_method, subject)
          # Get the failure message, which has to be done after the matching.
          failure_message = matcher.send(matcher_failure_message_method)

          [test_result, failure_message]
        end

        protected

        def name_prefix
          'assert'
        end

        def matcher_test_method
          :matches?
        end

        def matcher_failure_message_method
          :failure_message
        end
      end

      class MatcherRefutation < MatcherAssertion
        protected

        def name_prefix
          'refute'
        end

        def matcher_test_method
          :does_not_match?
        end

        def matcher_failure_message_method
          :failure_message_when_negated
        end
      end
    end
  end
end
