class CreateProjectStakeholders < ActiveRecord::Migration[8.0]
  def change
    create_table :project_stakeholders do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :account, null: false, foreign_key: true

      t.index %i[project_id account_id], unique: true

      t.timestamps
    end
  end
end
