class Project < ApplicationRecord
  attr_accessor :owner_account

  after_create_commit :associate_creator_account, if: -> { owner_account.present? }

  has_many :project_collaborators, dependent: :destroy
  has_many :collaborators, through: :project_collaborators, source: :account

  validates :description, presence: true
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  validates :name, presence: true
  validates :start_date, presence: true

  private
    def associate_creator_account
      ProjectCollaborator.create(account: owner_account, project: self, role: :owner)
    end
end
