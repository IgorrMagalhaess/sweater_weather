class Api::V1::ForecastController < ApplicationController
  def index
    @coordinates = LocationFacade.new(params[:location]).coordinates.values.join(',')
    
  end
end