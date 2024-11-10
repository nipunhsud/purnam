class User < ApplicationRecord
  has_secure_password

  has_one :account, dependent: :destroy
  has_many :sessions, dependent: :destroy

  has_many :collaboration_projects, through: :account
  has_many :project_collaborators, through: :account
  has_many :project_stakeholders, through: :account
  has_many :stakeholder_projects, through: :account

  normalizes :email_address, with: ->(email) { email.strip.downcase }

  validates :account, presence: true
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  accepts_nested_attributes_for :account
  validates_associated :account
end
