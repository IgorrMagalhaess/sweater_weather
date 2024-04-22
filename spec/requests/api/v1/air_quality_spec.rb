require "rails_helper"

RSpec.describe "Air Quality Endpoint" do
  before do
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

  end

  describe "GET /api/v1/air_quality?country={country}" do
    it 'returns the air quality in the capital of the country the the user provided', :vcr do
      get "/api/v1/air_quality?country=India"

      expect(response).to be_successful
      expect(response.status).to eq 200

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to eq(nil)

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq("air_quality")
      
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:aqi)
      expect(json[:data][:attributes][:aqi]).to be_a(Integer)
      expect(json[:data][:attributes]).to have_key(:datetime)
      expect(json[:data][:attributes][:aqi]).to be_a(Integer)
      expect(json[:data][:attributes]).to have_key(:readable_aqi)
    end
  end
end