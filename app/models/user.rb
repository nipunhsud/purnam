class User < ApplicationRecord
  has_secure_password

  # Associations
  has_one :account, dependent: :destroy
  has_many :sessions, dependent: :destroy

  # Normalization
  normalizes :email_address, with: ->(email) { email.strip.downcase }

  # Validations
  validates :account, presence: true
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  accepts_nested_attributes_for :account
  validates_associated :account
end
