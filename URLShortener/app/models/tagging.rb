
class Tagging < ActiveRecord::Base
  validates :tag_topic_id, :shortened_url_id, presence: true
  validates :shortened_url_id, uniquness: { scope: :tag_topic_id }

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'ShortenedUrl'

  belongs_to :tag_topic,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: 'TagTopic'
end
