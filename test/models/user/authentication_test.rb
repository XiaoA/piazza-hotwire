require "test_helper"

class User::AuthenticationTest < ActiveSupport::TestCase
  test "password length must be between 8 and ActiveModel's maximum" do
    @user = User.new(
      name: "Sherlock",
      email: "sherlock@example.com",
      password: "",
      password_confirmation: "",
    )
    assert_not @user.valid?

    @user.password = @user.password_confirmation = "password"
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = @user.password_confirmation = "a" * (max_length + 1)
    assert_not @user.valid?
  end

  test "can create a session with email and correct password" do
    @app_session = User.create_app_session(
      email: "yoda@example.com",
      password: "password",
    )
    assert_not_nil @app_session
    assert_not_nil @app_session.token
  end

  test "cannot create a session with email and incorrect password" do
    @app_session = User.create_app_session(
      email: "yoda@example.com",
      password: "wrongpassword",
    )
    assert_nil @app_session
  end

  test "creating a session with invalid email returns nil" do
    @app_session = User.create_app_session(
      email: "invalid@example.com",
      password: "wrongpassword",
    )
    assert_nil @app_session
  end

  test "authenticates with a valid session id and token" do
    @user = users(:yoda)
    @app_session = @user.app_sessions.create

    assert_equal @app_session,
    @user.authenticate_app_session(@app_session.id, @app_session.token)
  end

  test "authentication fails with invalid token" do
    @user = users(:yoda)

    assert_not @user.authenticate_app_session(50, "token")
  end  
end
