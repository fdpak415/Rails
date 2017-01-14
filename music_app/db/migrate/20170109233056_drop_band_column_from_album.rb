class DropBandColumnFromAlbum < ActiveRecord::Migration[5.0]
  def change
    remove_column :albums, :band
  end
end
