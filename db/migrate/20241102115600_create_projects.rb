class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false

      t.text :description, null: false

      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
