class Api::V1::ForecastController < ApplicationController
  def index
    coordinates = LocationFacade.new(params[:location]).coordinates.values.join(',')
    forecast = ForecastFacade.new(coordinates).forecast
    render json: ForecastSerializer.new(forecast)
  end
end