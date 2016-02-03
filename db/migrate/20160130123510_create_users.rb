class CreateUsers < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if direction == :up
  end

  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.timestamps null: false
    end
    add_index :users, :email,                unique: true
  end
end



  