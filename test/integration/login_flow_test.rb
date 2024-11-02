require_relative "authentication_flow_test"

class LoginFlowTest < AuthenticationFlowTest
  setup do
    @user = users(:one)
  end

  test "user can login" do
    visit_root_path
    visit_new_session_path

    wrong_login
    right_login

    logout
  end
end
