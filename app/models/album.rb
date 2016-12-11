class Album < ActiveRecord::Base
  validates :name, :band_id, :quality, presence: true
  belongs_to :band

  has_many :tracks, dependent: :destroy
end
