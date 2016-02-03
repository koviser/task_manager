class CreateTasks < ActiveRecord::Migration
  def change
    create_table(:tasks) do |t|
      t.string :name, null: false
      t.belongs_to :project, index: true, null: false
      t.integer :index
      t.integer :priority, null: false, default: 1, index: true
      t.datetime :dedlayn
      t.boolean :finish
      t.timestamps null: false
    end
  end
end
