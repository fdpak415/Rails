class AddIndexToContact < ActiveRecord::Migration[5.0]
  def change
    add_index :contacts, :user_id
    add_index :contacts, :email, unique: true
  end
end
