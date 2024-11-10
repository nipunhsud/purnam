require_relative "../helpers/session_helpers"

class RegistrationFlowTest < ActionDispatch::IntegrationTest
  include SessionHelpers

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

  test "user can register" do
    visit_root_path
    visit_new_users_path

    wrong_registration
    right_registration

    logout

    wrong_login
    right_login

    logout
  end

  private
    def visit_new_users_path
      get new_user_url

      assert_response :success
      assert_select "h1", "Sign Up"
    end

    def wrong_registration
      post users_url, params: { user: @user_params.except(:account_attributes) }

      assert_response :unprocessable_entity
    end

    def right_registration
      post users_url, params: { user: @user_params }

      assert_response :redirect
      assert_redirected_to projects_url
      flash[:notice] = "Welcome"
    end
end
