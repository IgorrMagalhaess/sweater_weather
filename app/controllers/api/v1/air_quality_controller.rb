class Api::V1::AirQualityController < ApplicationController
  def index
    coordinates = LocationFacade.new(params[:country]).coordinates.values
    lat = coordinates[0]
    lon = coordinates[1]
    air_quality = AirQualityFacade.new(lat, lon)
  end
end