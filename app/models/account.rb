class Account < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_many :project_collaborators, dependent: :destroy
  has_many :projects, through: :project_collaborators

  normalizes :first_name, with: ->(name) { name.strip }
  normalizes :last_name, with: ->(name) { name.strip }

  validates :first_name, :last_name, presence: true
end
