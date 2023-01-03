class User < ApplicationRecord
  validates :name, presence: true
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
end
