class Api::V0::RoadTripController < ApplicationController
before_action :find_user, only: [:create]

  def create
    start_city = params[:road_trip][:origin].gsub(/\s+/, "")
    end_city = params[:road_trip][:destination].gsub(/\s+/, "")
    route_info = RoutesFacade.new(start_city, end_city).route_info
    forecast = ForecastFacade.new(end_city, route_info[:travel_time]).forecast_end_route
    render json: RoadTripSerializer.new(params[:road_trip][:origin], params[:road_trip][:destination], route_info, forecast).serialize
  end

  private
  def find_user
    @user = User.find_by(api_key: params[:road_trip][:api_key])
    message = "Wrong/missing API key"
    render json: ErrorSerializer.new(ErrorMessage.new(message, 400))
      .serialize_json, status: :bad_request unless @user
  end
end