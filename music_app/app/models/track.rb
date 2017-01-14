class Track < ActiveRecord::Base
  validates :name, :album_id, :type, :lyrics, presence: true

  belongs_to :album,
  class_name: 'Album',
  foreign_key: :album_id


end
