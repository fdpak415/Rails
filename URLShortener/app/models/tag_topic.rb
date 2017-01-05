
class TagTopic < ActiveRecord::Base
  validates :name, presence: true

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: 'Tagging',
    dependent: :destroy

  def popular_links
    shortened_urls.joins(:visits)
    .group(:short_url)
    .order('COUNT(visits.id) DESC')
    .select('long_url, short_url, COUNT(visits.id) as number_of_visits')
    .limit(5)
  end

end
