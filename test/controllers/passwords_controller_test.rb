require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @valid_token = @user.password_reset_token
    @invalid_token = "invalid_token"
  end

  test "should get new" do
    get new_password_url
    assert_response :success
  end

  test "should create password reset and redirect if user exists" do
    assert_enqueued_emails 1 do
      post passwords_url, params: { email_address: @user.email_address }
    end

    assert_redirected_to new_session_url
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should create password reset and redirect even if user does not exist" do
    assert_no_enqueued_emails do
      post passwords_url, params: { email_address: "nonexistent@example.com" }
    end

    assert_redirected_to new_session_url
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should get edit with valid token" do
    get edit_password_url(token: @valid_token)

    assert_response :success
  end

  test "should redirect to new password url with invalid token" do
    get edit_password_url(token: @invalid_token)

    assert_redirected_to new_password_url
    assert_equal "Password reset link is invalid or has expired.", flash[:alert]
  end

  test "should update password with valid token" do
    patch password_url(token: @valid_token), params: { password: "newpassword", password_confirmation: "newpassword" }

    assert_redirected_to new_session_url
    assert_equal "Password has been reset.", flash[:notice]
    assert @user.reload.authenticate("newpassword")
  end

  test "should not update password if confirmation does not match" do
    patch password_url(token: @valid_token), params: { password: "newpassword", password_confirmation: "differentpassword" }

    assert_redirected_to edit_password_url(token: @valid_token)
    assert_equal "Passwords did not match.", flash[:alert]
    assert_not @user.reload.authenticate("newpassword")
  end
end
