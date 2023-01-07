require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires a name" do
    @user = User.new(
      name: "",
      email: "andrew@example.com",
      password: "password",
      password_confirmation: "password",
    )

    assert_not @user.valid?
  end

  test "requires a valid email" do
    @user = User.new(
      name: "Andrew",
      email: "",
      password: "password",
      password_confirmation: "password"
    )
    assert_not @user.valid?

    @user.email = "invalid"
    assert_not @user.valid?

    @user.email = "andrew@example.com"
    assert @user.valid?
  end

  test "requires a unique email" do
    @existing_user = User.create(
      name: "Andrew",
      email: "andrew@example.com",
      password: "password",
      password_confirmation: "password",
    )
    assert @existing_user.persisted?

    @user = User.new(
      name: "Drew",
      email: "andrew@example.com",
      password: "password",
      password_confirmation: "password"
    )
    assert_not @user.valid?
  end

  test "name and email fields do not contain whitespaces" do
    @user = User.create(
      name: " Andrew ",
      email: " andrew@example.com ",
      password: "password",
      password_confirmation: "password",
    )

    assert_equal "Andrew", @user.name
    assert_equal "andrew@example.com", @user.email
  end

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
end
