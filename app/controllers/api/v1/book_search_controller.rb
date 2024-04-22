class Api::V1::BookSearchController < ApplicationController
  def index
    location = params[:location]
    quantity = params[:quantity]
    forecast = ForecastFacade.new(location).forecast.resumed_forecast
    require 'pry' ; binding.pry
    book_search = BooksFacade.new(quantity)
    
  end
end