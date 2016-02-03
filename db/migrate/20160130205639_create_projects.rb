class CreateProjects < ActiveRecord::Migration
  def change
    create_table(:projects) do |t|
      t.string :name, null: false
      t.string :picture
      t.belongs_to :user, index: true, null: false
      t.timestamps null: false
    end
    add_index :projects, :name
  end
end