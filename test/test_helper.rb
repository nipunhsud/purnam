ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require_relative "./custom_assertions"
require "rails/test_help"

module ActiveSupport
  # Base Case for almost all the tests
  class TestCase
    include CustomAssertions

    alias :assert_association :assert_respond_to

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def authenticate_user(user)
      user = users(user)

      post session_url, params: { email_address: user.email_address, password: "password" }

      user.reload
    end

    def terminate_session
      delete session_url
    end
  end
end
