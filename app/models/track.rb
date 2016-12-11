class Track < ActiveRecord::Base
  validates :name, :album_id, :lyrics, :status, presence: true
  belongs_to :album

  has_one :band,
    through: :album,
    source: :band
end
