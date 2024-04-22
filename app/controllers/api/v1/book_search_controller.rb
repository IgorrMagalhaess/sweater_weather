class Api::V1::BookSearchController < ApplicationController
  def index
    forecast = ForecastFacade.new(params[:location])
    require 'pry' ; binding.pry
  end
end