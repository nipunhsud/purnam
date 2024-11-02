require "test_helper"

class AuthenticationFlowTest < ActionDispatch::IntegrationTest
  protected
    def visit_root_path
      get root_url

      assert_response :success
      assert_select "h1", "Purnam"
    end

    def visit_new_session_path
      get new_session_url

      assert_response :success
      assert_select "h1", "Sign In"
    end

    def wrong_login
      post session_url, params: { email_address: @user.email_address, password: "wrongpassword" }

      assert_response :redirect
      assert_redirected_to new_session_url

      assert_equal flash[:alert], "Try another email address or password"
    end

    def right_login
      follow_redirect!

      post session_url, params: { email_address: @user.email_address, password: "password" }

      assert_response :redirect
      assert_redirected_to projects_url

      assert_equal flash[:notice], "Welcome!"
    end

    def logout
      follow_redirect!

      delete session_url

      assert_response :redirect
      assert_redirected_to new_session_url

      assert_equal flash[:notice], "Logged Out Successfully!"
    end
end
