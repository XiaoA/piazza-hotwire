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
end
