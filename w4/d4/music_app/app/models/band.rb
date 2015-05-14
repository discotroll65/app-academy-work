class Band < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums

  validates :name, presence: true, uniqueness: true
end
