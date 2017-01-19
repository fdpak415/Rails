class AddIndexComment < ActiveRecord::Migration[5.0]
  def change
    add_index :comments, :post_id
  end
end
