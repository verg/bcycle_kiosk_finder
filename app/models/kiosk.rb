class Kiosk < ActiveRecord::Base
  geocoded_by :address

  validates :latitude, :longitude, presence: true
  def address
    "#{street}, #{city}, #{state} #{zip_code}"
  end

  def to_coordinates
    [latitude, longitude]
  end

  def to_gmap
    "https://maps.google.com/?q=#{latitude},#{longitude}"
  end

  # used with bootstrap to display table colors for kiosk results
  def status_to_css
    if status != "Active" || docks_available < 1
      "error"
    elsif docks_available == 1
      "warning"
    else
      "success"
    end
  end
end
