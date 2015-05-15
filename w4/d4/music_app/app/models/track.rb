class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band, through: :album
  has_many :notes

  validates :album_id, :name, :track_type, presence: true
  validates :track_type, inclusion: %w[bonus regular]
  validates_uniqueness_of(
    :name,
    scope: [:album_id],
    message: "of track already exists on Album"
  )
end
