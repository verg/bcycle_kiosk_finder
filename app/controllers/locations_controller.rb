class LocationsController < ApplicationController
  SearchDiameter = 0.01 # in miles

  def new
    @location = Location.new
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    @locations = Location.all
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location
    else
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
end
