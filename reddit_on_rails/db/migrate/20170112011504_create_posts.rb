class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content, null: false
      t.integer :sub_id, null: false
      t.integer :author_id, null: false
      t.timestamps
    end
    add_index :posts, :sub_id, unique: true
    add_index :posts, :author_id, unique: true
  end
end
