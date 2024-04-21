class Api::V1::ForecastController < ApplicationController
  def index
    @coordinates = LocationFacade.new(params[:location]).coordinates.values.join(',')
    @forecast = ForecastFacade.new(@coordinates).forecast
    require 'pry' ; binding.pry
  end
end