require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url

    assert_response :success
  end

  test "should redirect back to projects_url if user is already authenticated" do
    authenticate_user(:one)

    get new_user_url

    assert_response :redirect
    assert_redirected_to projects_url
  end

  test "should post create" do
    assert_difference("User.count") do
      post users_url, params: { user: user_params }
    end

    assert_response :redirect
    assert_redirected_to projects_url
  end

  test "should render error if user registration fails" do
    post users_path, params: { user: invalid_user_params }

    assert_response :unprocessable_entity
  end

  private
    def user_params
      {
        email_address: "random@newuser.com",
        password: "password",
        account_attributes: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name
        }
      }
    end

    def invalid_user_params
      {
        email_address: Faker::Internet.email,
        password: "password"
      }
    end
end
