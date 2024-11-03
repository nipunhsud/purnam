require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user_params = {
      email_address: Faker::Internet.email,
      password: "password",
      account_attributes: {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      }
    }
  end

  # Associations
  test "should test all associations of user" do
    %i[account sessions projects project_collaborators].each do |association|
      assert_association @user, association
    end
  end

  # Normalization
  test "should normalize email_address" do
    user = User.new(email_address: "  sample@email.com   ", password: "password")

    assert user.email_address == "sample@email.com"
  end

  # Validations
  test "should check if @user_params are valid" do
    user = User.new @user_params

    assert user.valid?
  end

  test "should check presence of account" do
    user = User.new @user_params.except(:account_attributes)

    assert_not user.valid?
  end

  test "should check of account's validations" do
    user = User.new @user_params.merge(account_attributes: { first_name: nil })

    assert_not user.valid?
  end

  test "should check presence of email" do
    user = User.new @user_params.merge(email_address: nil)

    assert_not user.valid?
  end

  test "should check uniqueness of email" do
    user = User.new @user_params.merge(email_address: @user.email_address)

    assert_not user.valid?
  end

  test "should check format of email" do
    user = User.new @user_params.merge(email_address: "wrongemail")

    assert_not user.valid?
  end

  test "should check presence of password" do
    user = User.new @user_params.merge(password: nil)

    assert_not user.valid?
  end

  # Callbacks
  test "should create both the user and account in one go" do
    user = User.new @user_params

    assert_difference("Account.count") { user.save }
  end

  test "should delete account if user is deleted" do
    assert_difference("Account.count", -1) { @user.destroy }
  end

  test "should delete sessions if user is deleted" do
    assert_difference("Session.count", -@user.sessions.count) { @user.destroy }
  end
end
