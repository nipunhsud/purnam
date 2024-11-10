class ProjectCollaborator < ApplicationRecord
  belongs_to :account
  belongs_to :project

  validates :account_id, uniqueness: { scope: :project_id }

  enum :role, { user: 0, admin: 1, owner: 2 }
end
