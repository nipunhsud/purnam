require_relative "../helpers/session_helpers"

class LoginFlowTest < ActionDispatch::IntegrationTest
  include SessionHelpers

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
