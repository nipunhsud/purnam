class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
  end
end
