require "rails_helper"

RSpec.describe "Forecast Api", type: :request do
  before do
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  describe "GET /api/v1/forecast?location" do
    it "returns the current and forecast weather information for the given location", :vcr do
      get "/api/v1/forecast?location=Atlanta,GA", headers: @headers

      forecast_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      require 'pry' ; binding.pry
    end
  end
end