class ChangeTextColumnForAlbumAndTrack < ActiveRecord::Migration[5.0]
  def change
    rename_column :albums, :type, :recording
    rename_column :tracks, :type, :recording
  end
end
