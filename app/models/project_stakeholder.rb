class ProjectStakeholder < ApplicationRecord
  belongs_to :project
  belongs_to :account

  validates :account_id, uniqueness: { scope: :project_id }
end
