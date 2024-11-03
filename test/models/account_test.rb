require "test_helper"

class AccountTest < ActiveSupport::TestCase
  setup do
    @user = users(:without_account)
    @account = accounts(:one)

    @account_params = {
      user_id: @user.id,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }
  end

  # Associations
  test "should test all accounts associations" do
    %i[user project_collaborators projects].each do |association|
      assert_association @account, association
    end
  end

  # Normalization
  test "should normalize first_name" do
    account = Account.new(user: @user, first_name: "  First  ", last_name: "Last")

    assert account.first_name == "First"
  end

  test "should normalize last_name" do
    account = Account.new(user: @user, first_name: "First", last_name: "   Last ")

    assert account.last_name == "Last"
  end

  # Validations
  test "should check if @account_params is valid" do
    account = Account.new @account_params

    assert account.valid?
  end

  test "should check presence of user_id" do
    account = Account.new @account_params.merge(user_id: nil)

    assert_not account.valid?
  end

  test "should check first_name presence" do
    account = Account.new @account_params.merge(first_name: nil)

    assert_not account.valid?
  end

  test "should check last_name presence" do
    account = Account.new @account_params.merge(last_name: "   ")

    assert_not account.valid?
  end

  # Callbacks
  test "should delete user if account is destroyed" do
    assert_difference("User.count", -1) { @account.destroy }
  end

  test "should delete project_collaborators if account is destroyed" do
    assert_difference("ProjectCollaborator.count", -@account.project_collaborators.count) { @account.destroy }
  end
end
