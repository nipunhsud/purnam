require "test_helper"

class SessionTest < ActiveSupport::TestCase
  setup do
    @session = sessions(:one)
  end

  # Validations
  test "should test user_id presence" do
    session = Session.new(user_id: nil)

    assert_not session.valid?
  end
end
