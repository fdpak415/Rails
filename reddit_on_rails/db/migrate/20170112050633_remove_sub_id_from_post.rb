class RemoveSubIdFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :sub_id, :integer
  end
end
