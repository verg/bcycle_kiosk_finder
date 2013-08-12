require 'faraday'
require 'multi_json'

module BikeShareClient

  URI = 'http://api.bcycle.com/services/mobile.svc/ListKiosks'

  # Returns Array of BikeShareResult objects
  def self.get
    kiosks = parsed_json
    kiosks.map{|kiosk_hash| BikeShareResult.new(kiosk_hash) }
  end


  private

  def self.parsed_json
    unwind(MultiJson.load(raw_data))
  end

  def self.raw_data
    Faraday.get(URI).body
  end

  def self.unwind(data)
    data['d']['list']
  end
end
