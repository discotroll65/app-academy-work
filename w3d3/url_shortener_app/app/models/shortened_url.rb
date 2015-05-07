class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :visited_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tags,
    through: :taggings,
    source: :tag
  )

  def self.create_for_user_and_long_url!(user, given_long_url)
    ShortenedUrl.create!(
      long_url: given_long_url,
      short_url: self.random_code,
      submitter_id: user.id
    )
  end

  def self.random_code
    test_url = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: test_url)
      test_url = SecureRandom.urlsafe_base64(16)
    end
    test_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select('visitor_id').distinct.where('visits.updated_at > ?', 10.minutes.ago).count
  end
end
