class Api::V1::ForecastController < ApplicationController
  def index
    @coordinates = LocationFacade.new(params[:location])
    require 'pry' ; binding.pry
  end
end