require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:yoda)
  end

  test "user is logged in and redirected to home with correct credentials" do
    assert_difference("@user.app_sessions.count", 1) {
      post login_path, params: {
             user: {
               email: "yoda@example.com",
               password: "password"
             }
           }
    }

    assert_redirected_to root_path
  end

  test "error is rendered for login with incorrect credentials" do
    post login_path, params: {
           user: {
             email: "wrongemail@example.com",
             password: "password"
           }
         }

    assert_select ".notification",
                  I18n.t("sessions.create.incorrect_details")
  end
end
