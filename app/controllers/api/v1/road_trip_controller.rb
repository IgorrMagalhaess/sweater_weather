class Api::V1::RoadTripController < ApplicationController
before_action :find_user, only: [:create]

  def create
    start_city = params[:road_trip][:origin].gsub(/\s+/, "")
    end_city = params[:road_trip][:destination].gsub(/\s+/, "")
    route_info = RoutesFacade.new(start_city, end_city).route_info
    require 'pry' ; binding.pry
  end

  private
  def find_user
    @user = User.find_by(api_key: params[:api_key])
  end
end