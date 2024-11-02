require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_url

    assert_response :success
  end

  test "should redirect back to projects_url if the user is already authenticated" do
    authenticate_user(:one)

    get new_session_url

    assert_response :redirect
    assert_redirected_to projects_url
  end

  test "should post create" do
    user = users(:one)
    assert_difference("Session.count") do
      post session_url, params: session_params(user.email_address)
    end

    assert_response :redirect
    assert_redirected_to projects_url
  end

  test "should render error if login fails" do
    post session_url, params: invalid_session_params

    assert_response :redirect
    assert_redirected_to new_session_url
  end

  test "should logout" do
    delete session_url

    assert_response :redirect
    assert_redirected_to new_session_url

    authenticate_user(:one)

    delete session_url

    assert_redirected_to new_session_url
  end

  private
    def session_params(email_address)
      { email_address:, password: "password" }
    end

    def invalid_session_params
      { email_address: "user@1.com", password: "wrongpassword" }
    end
end
