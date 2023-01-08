require "test_helper"

class AppSessionTest < ActiveSupport::TestCase
  setup do
    @user = users(:yoda)
  end

  test "a new token is generated and saved when a new record is created" do
    app_session = @user.app_sessions.create

    assert app_session.persisted?
    assert_not_nil app_session.token_digest
    assert app_session.authenticate_token(app_session.token)
  end
end
