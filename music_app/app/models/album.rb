class Album < ActiveRecord::Base
  validates :name, :band_id, :year, :recording, presence: true

  belongs_to :band,
  class_name: 'Band',
  foreign_key: :band_id

  has_many :tracks, dependent: :destroy
end
