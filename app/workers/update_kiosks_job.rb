class UpdateKiosksJob
  @queue = :kiosks_queue
  def self.perform
    kiosk_results = BikeShareClient.get
    kiosk_results.each do |kiosk_result|
      kiosk = Kiosk.find_or_create_by(external_id: kiosk_result.external_id)
      kiosk.update(kiosk_result.to_hash)
    end
  end
end
