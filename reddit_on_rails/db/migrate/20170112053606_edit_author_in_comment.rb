class EditAuthorInComment < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :author, :author_id
    add_index :comments, :author_id
  end
end
