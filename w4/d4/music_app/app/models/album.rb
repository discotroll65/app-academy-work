class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks, dependent: :destroy

  validates :band_id, :name, :recording_style, presence: true
  validates :recording_style, inclusion: %w[live studio]
  validates_uniqueness_of(
   :name,
   scope: [:band_id],
   message: "of album already exists for this band."
  )
end
