class BikeShareResult
  attr_reader :external_id, :name, :city, :state, :street, :zip_code, :latitude, :longitude,
    :status,:docks_available, :bikes_available

  def initialize(kiosk)
    @external_id = kiosk["Id"]
    @name        = kiosk["Name"] # "N. Webster & E. Mifflin"
    @city        = kiosk['Address']['City'] # "Madison"
    @state       = kiosk['Address']['State'] # "WI"
    @street      = kiosk['Address']['Street'].strip # "117 Wisconsin Avenue"
    @zip_code    = kiosk['Address']['ZipCode'] # "117 Wisconsin Avenue"
    @latitude    = kiosk['Location']['Latitude']
    @longitude   = kiosk['Location']['Longitude']
    # e.g. "Active", "ComingSoon", "PartialService",  "Unavailable"
    @status          = kiosk["Status"]
    @docks_available = kiosk["DocksAvailable"] # 0
    @bikes_available = kiosk["BikesAvailable"] # 3
  end

  def to_hash
    { external_id: external_id,
      name: name,
      city: city,
      state: state,
      street: street,
      zip_code: zip_code,
      latitude: latitude,
      longitude: longitude,
      status: status,
      docks_available: docks_available,
      bikes_available: bikes_available }
  end
end
