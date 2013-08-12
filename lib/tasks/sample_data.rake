namespace :db do
  desc "Fill db with sample Kiosk objs"
  task populate: :environment do
    kiosk_results = BikeShareClient.get
    kiosk_results.each do |kiosk|
      Kiosk.create!(kiosk.to_hash)
    end
  end
end
