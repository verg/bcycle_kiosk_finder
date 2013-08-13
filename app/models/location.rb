class Location < ActiveRecord::Base
  belongs_to :user
  extend ::Geocoder::Model::ActiveRecord
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  before_validation :geocode, :if => :address_changed?
  validates :latitude, :longitude, presence: true

  def to_coordinates
    [latitude, longitude]
  end

  def coords_to_uri
    "/#{latitude}/#{longitude}"
  end
end
