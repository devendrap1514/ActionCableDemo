class User < ApplicationRecord
  self.table_name = :users

  has_secure_password

  has_many :chat_rooms

  before_validation lambda {
    self.email.strip!
    self.email.downcase!
  }, if: lambda { self.email.present? }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
