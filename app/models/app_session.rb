class AppSession < ApplicationRecord
  belongs_to :user

  has_secure_password :token, validations: false

  before_create {
    self.token = self.class.generate_unique_secure_token
  }
end
