class Project < ApplicationRecord
  attr_accessor :owner_account

  default_scope { order(created_at: :desc) }

  after_create_commit :associate_creator_account, if: -> { owner_account.present? }

  has_many :project_collaborators, dependent: :destroy
  has_many :project_stakeholders, dependent: :destroy

  has_many :collaborators, through: :project_collaborators, source: :account
  has_many :stakeholders, through: :project_stakeholders, source: :account

  validates :description, presence: true
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  validates :name, presence: true
  validates :start_date, presence: true

  private
    def associate_creator_account
      ProjectCollaborator.create(account: owner_account, project: self, role: :owner)
      ProjectStakeholder.create(account: owner_account, project: self)
    end
end
