class RemoveUniqueIndexPost < ActiveRecord::Migration[5.0]
  def change
    remove_index :posts, :user_id
    add_index :posts, :user_id
  end
end
