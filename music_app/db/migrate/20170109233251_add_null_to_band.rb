class AddNullToBand < ActiveRecord::Migration[5.0]
  def change
    change_column :albums, :name, :string, null: false
    change_column :albums, :band_id, :integer, null: false
    change_column :albums, :year, :integer, null: false
    change_column :albums, :type, :string, null: false 
  end
end
