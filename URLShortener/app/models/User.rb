class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'ShortenedUrl'

  has_many :visited_urls,
    -> { distinct },
    through: :visits,
    source: :shortened_url

  has_many :visits,
    class_name: "Visit",
    foreign_key: :user_id,
    primary_key: :id
end
