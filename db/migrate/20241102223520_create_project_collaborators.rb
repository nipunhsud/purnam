class CreateProjectCollaborators < ActiveRecord::Migration[8.0]
  def change
    create_table :project_collaborators do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :project, null: false, foreign_key: true

      t.integer :role, null: false, default: 0

      t.index %i[account_id project_id], unique: true

      t.timestamps
    end
  end
end
