require "rails_helper"

RSpec.describe "Roadtrip Endpoints", type: :request do
  before do
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    @user = User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password')
    @user_api = @user.api_key
  end

  describe "POST /api/v1/road_trip" do
    it 'returns the start and end city, travel time and weather at destination', :vcr do
      trip_params = {
        origin: "Cincinatti, OH",
        destination: "Chicago, IL",
        api_key: @user.api_key
      }
      post "/api/v1/road_trip", headers: @headers, params: JSON.generate(road_trip: trip_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip_response = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip_response).to have_key(:data)
      expect(road_trip_response[:data]).to be_a(Hash)

      expect(road_trip_response[:data]).to have_key(:id)
      expect(road_trip_response[:data][:id]).to eq("null")

      expect(road_trip_response[:data]).to have_key(:type)
      expect(road_trip_response[:data][:type]).to eq("road_trip")

      expect(road_trip_response[:data]).to have_key(:attributes)
      expect(road_trip_response[:data][:attributes]).to be_a(Hash)

      road_trip_attr = road_trip_response[:data][:attributes]

      expect(road_trip_attr).to have_key(:start_city)
      expect(road_trip_attr[:start_city]).to eq(trip_params[:origin])

      expect(road_trip_attr).to have_key(:end_city)
      expect(road_trip_attr[:end_city]).to eq(trip_params[:destination])

      expect(road_trip_attr).to have_key(:travel_time)
      expect(road_trip_attr[:travel_time]).to be_a(String)

      expect(road_trip_attr).to have_key(:weather_at_eta)
      expect(road_trip_attr[:weather_at_eta]).to be_a(Hash)

      expect(road_trip_attr[:weather_at_eta]).to have_key(:datetime)
      expect(road_trip_attr[:weather_at_eta][:datetime]).to be_a(String)

      expect(road_trip_attr[:weather_at_eta]).to have_key(:temperature)
      expect(road_trip_attr[:weather_at_eta][:temperature]).to be_a(Float)

      expect(road_trip_attr[:weather_at_eta]).to have_key(:condition)
      expect(road_trip_attr[:weather_at_eta][:condition]).to be_a(String)
    end
  end
end