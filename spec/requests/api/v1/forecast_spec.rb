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
      expect(response.status).to eq(200)

      expect(forecast_response[:data]).to be_a(Hash)
      expect(forecast_response[:data][:id]).to eq(nil)
      expect(forecast_response[:data][:type]).to eq('forecast')

      expect(forecast_response[:data][:attributes]).to have_key(:current_weather)
      expect(forecast_response[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast_response[:data][:attributes]).to have_key(:hourly_weather)

      # current weather
      current_weather = forecast_response[:data][:attributes][:current_weather]

      expect(current_weather).to have_key(:last_updated)
      expect(current_weather[:last_updated]).to be_a(String)

      expect(current_weather).to have_key(:temperature)
      expect(current_weather[:temperature]).to be_a(Float)

      expect(current_weather).to have_key(:feels_like)
      expect(current_weather[:feels_like]).to be_a(Float)

      expect(current_weather).to have_key(:humidity)
      expect(current_weather[:humidity]).to be_a(Integer)

      expect(current_weather).to have_key(:uvi)
      expect(current_weather[:uvi]).to be_a(Float)

      expect(current_weather).to have_key(:visibility)
      expect(current_weather[:visibility]).to be_a(Float)

      expect(current_weather).to have_key(:condition)
      expect(current_weather[:condition]).to be_a(String)

      expect(current_weather).to have_key(:icon)
      expect(current_weather[:icon]).to be_a(String)

      expect(current_weather).to_not have_key(:location)
      expect(current_weather).to_not have_key(:lat)
      expect(current_weather).to_not have_key(:long)
      expect(current_weather).to_not have_key(:wind)
      expect(current_weather).to_not have_key(:preciptation)

      # daily weather
      daily_weather = forecast_response[:data][:attributes][:daily_weather]
      
      expect(daily_weather).to be_an(Array)

      expect(daily_weather.first).to have_key(:date)
      expect(daily_weather.first[:date]).to_not eq(daily_weather.last[:date])
      expect(daily_weather.first[:date]).to be_a(String)

      expect(daily_weather.first).to have_key(:sunrise)
      expect(daily_weather.first[:sunrise]).to be_a(String)

      expect(daily_weather.first).to have_key(:sunset)
      expect(daily_weather.first[:sunset]).to be_a(String)
      
      expect(daily_weather.first).to have_key(:max_temp)
      expect(daily_weather.first[:max_temp]).to be_a(Float)

      expect(daily_weather.first).to have_key(:min_temp)
      expect(daily_weather.first[:min_temp]).to be_a(Float)

      expect(daily_weather.first).to have_key(:condition)
      expect(daily_weather.first[:condition]).to be_a(String)

      expect(daily_weather.first).to have_key(:icon)
      expect(daily_weather.first[:icon]).to be_a(String)

      expect(daily_weather.first).to_not have_key(:moon_phase)
      expect(daily_weather.first).to_not have_key(:chance_of_rain)
      expect(daily_weather.first).to_not have_key(:totalprecip_in)
      expect(daily_weather.first).to_not have_key(:avg_temp)
      expect(daily_weather.first).to_not have_key(:wind)
      expect(daily_weather.first).to_not have_key(:feels_like)

      # hourly weather
      hourly_weather = forecast_response[:data][:attributes][:hourly_weather]

      expect(hourly_weather).to be_an(Array)

      expect(hourly_weather.first).to have_key(:time)
      expect(hourly_weather.first[:time]).to eq("00:00")

      expect(hourly_weather.last).to have_key(:time)
      expect(hourly_weather.last[:time]).to eq("23:00")

      expect(hourly_weather.first).to have_key(:temperature)
      expect(hourly_weather.first[:temperature]).to be_a(Float)

      expect(hourly_weather.first).to have_key(:condition)
      expect(hourly_weather.first[:condition]).to be_a(String)

      expect(hourly_weather.first).to have_key(:icon)
      expect(hourly_weather.first[:icon]).to be_a(String)

      expect(hourly_weather.first).to_not have_key(:sunrise_time)
      expect(hourly_weather.first).to_not have_key(:pressure)
      expect(hourly_weather.first).to_not have_key(:humidity)
      expect(hourly_weather.first).to_not have_key(:feels_like)
      expect(hourly_weather.first).to_not have_key(:location)
      expect(hourly_weather.first).to_not have_key(:lat)
      expect(hourly_weather.first).to_not have_key(:long)
      expect(hourly_weather.first).to_not have_key(:wind)
      expect(hourly_weather.first).to_not have_key(:preciptation)
    end
  end
end