# app/models/user.rb
class User < ApplicationRecord
  has_secure_password  # requires bcrypt gem; handles password & password_digest

  has_many :articles, dependent: :destroy

  # Validations
  validates :email,    presence: true, uniqueness: { case_sensitive: false },
                       format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 6 }, if: :new_record?

  before_save { self.email = email.downcase }
end
