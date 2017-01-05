class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Visit'



  def self.random_code
    loop do
      random_code = SecureRandom.urlsafe_base64(16)
      return random_code unless ShortenedUrl.exists?(short_url: random_code)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(long_url: long_url, short_url: ShortenedUrl.random_code,
    user_id: user.id)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits
      .select('user-id')
      .where("created_at > ?", 10.minutes.ago)
      .distinct
      .count
  end

  def no_spamming
    last_minute = ShortenedUrl
    .where("created_at >= ?", 1.minute.ago)
    .where(submitter_id: submitter_id)
    .length

    errors[:maximum] << "of five short urls per minute" if last_minute >= 5
  end

  def nonpremium_max
    return if User.find(self.submitter_id).premium

    number_of_urls =
    ShortenedUrl
    .where(submitter_id: submitter_id)
    .length

    if number_of_urls >= 5
      errors[:Only] << "premium members can create more than 5 short urls"
    end
  end

end
