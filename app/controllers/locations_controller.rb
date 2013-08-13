class LocationsController < ApplicationController
  SearchDiameter = 0.01 # in miles
  before_action :update_kiosks_async
  before_action :find_or_create_user

  def index
    update_kiosks_async
    @location = Location.new
    @locations = @current_user.locations
  end

  def show
    update_kiosks_async
    @destination = Location.find(params[:id])
    @locations = @current_user.locations
    @location = Location.new
    @kiosks = Kiosk.near(@destination.to_coordinates).first(4)
  end

  def create
    @locations = @current_user.locations
    @location = Location.new
    @destination = Location.new(location_params)
    @destination.user = @current_user

    if @destination.save
      @kiosks = Kiosk.near(@destination.to_coordinates).first(4)
      render 'index'
    else
      flash.now[:error] = "hmm... Can't find that location. Try again."
      render 'index'
    end
  end

  private

  def location_params
    params.require(:location).permit(:address, :latitude, :longitude)
  end

  def param_coordinates
    [params[:latitude], params[:longitude]]
  end

  def update_kiosks_async
    Resque.enqueue(UpdateKiosksJob) if kiosks_stale?
  end

  def kiosks_stale?
    Time.now - time_kiosks_updated > 1.minute
  end

  def time_kiosks_updated
    Kiosk.maximum('updated_at') || 1.minute.ago
  end
end
