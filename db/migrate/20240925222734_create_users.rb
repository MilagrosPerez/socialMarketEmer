class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :string, unique: true
    add_index :users, :username, unique: true
  end
end
