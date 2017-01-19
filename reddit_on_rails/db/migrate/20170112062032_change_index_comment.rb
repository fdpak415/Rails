class ChangeIndexComment < ActiveRecord::Migration[5.0]
  def change
    remove_index :comments, name: "index_comments_on_post_id"
    

  end
end
