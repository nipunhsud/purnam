class Account < ApplicationRecord
  # Associations
  belongs_to :user, dependent: :destroy

  # Normalization
  normalizes :first_name, with: ->(name) { name.strip }
  normalizes :last_name, with: ->(name) { name.strip }

  # Validations
  validates :first_name, :last_name, presence: true
end
