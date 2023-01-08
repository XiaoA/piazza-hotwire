class AppSession < ApplicationRecord
  belongs_to :user

  has_secure_password :token, validations: false

  before_create {
    self.token = self.class.generate_unique_secure_token
  }

  def to_h
    {
      user_id: user.id,
      app_session: id,
      token: self.token
    }
  end
end
