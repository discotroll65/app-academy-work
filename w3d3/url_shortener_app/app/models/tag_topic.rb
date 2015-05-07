class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(
    :short_urls,
    through: :taggings,
    source: :short_url
  )

  def n_most_popular_links(n)

    ShortenedUrl.find_by_sql([<<-SQL, limit: n])
      Select
        shortened_urls.short_url
      FROM
        shortened_urls
      JOIN
        visits ON shortened_urls.id = visits.visited_url_id
      JOIN
        taggings ON visits.visited_url_id = taggings.url_id
      JOIN
        tag_topics ON taggings.tag_id = tag_topics.id
      WHERE
        tag_topics.id = 1
      GROUP BY
        shortened_urls.short_url
      ORDER BY
        COUNT(*) DESC
      LIMIT
        :limit;
    SQL
    
    # ShortenedUrl
      # .select(:short_url)
      # .from(:shortened_urls)
      # .joins(:visits)
      # .joins(:taggings)
      # .joins(:tag_topics)
      # .where('tag_topics.id = ?', self.id)
      # .group(:short_url)
      # .limit(n).sort
  end

end
