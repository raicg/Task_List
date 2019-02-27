class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.references :user
      t.datetime :due_date

      t.timestamps
    end
  end
end
