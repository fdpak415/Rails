class CreateAlbum < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :band
      t.integer :band_id
      t.integer :year
      t.string :type

      t.timestamps
    end
    add_index :albums, :band_id
  end
end
