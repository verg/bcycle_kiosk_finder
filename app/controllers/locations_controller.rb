class LocationsController < ApplicationController
  SearchDiameter = 0.01 # in miles

  def new
    @location = Location.new
    @locations = Location.all
  end

  def show
    update_kiosks if kiosks_stale?
    @location = Location.find(params[:id])
    @locations = Location.all
    @kiosks = Kiosk.near(@location.to_coordinates).first(4)
  end

  def create
    @location = Location.new(location_params)
    @locations = Location.all
    if @location.save
      redirect_to @location
    else
      flash.now[:error] = "We couldn't find: #{@location.address}"
      render 'new'
    end
  end

  private

  def location_params
    params.require(:location).permit(:address, :latitude, :longitude)
  end

  def param_coordinates
    [params[:latitude], params[:longitude]]
  end

  def update_kiosks
    kiosk_results = BikeShareClient.get
    kiosk_results.each do |kiosk_result|
      kiosk = Kiosk.find_or_create_by(external_id: kiosk_result.external_id)
      kiosk.update(kiosk_result.to_hash)
    end
  end

  def kiosks_stale?
    Time.now - time_kiosks_updated > 1.minute
  end

  def time_kiosks_updated
    Kiosk.maximum('updated_at') || 1.minute.ago
  end
end
