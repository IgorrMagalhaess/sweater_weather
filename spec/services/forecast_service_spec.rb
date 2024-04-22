require "rails_helper"

RSpec.describe ForecastService do
  it "get forecast", :vcr do
    forecast = ForecastService.new.get_forecast("40.7128, -74.0060")

    expect(forecast).to have_key(:location)
    expect(forecast[:location]).to be_a Hash
    expect(forecast).to have_key(:current)
    expect(forecast[:current]).to have_key(:temp_f)
    expect(forecast[:current]).to have_key(:humidity)
    expect(forecast[:current]).to have_key(:feelslike_f)
    expect(forecast[:current]).to have_key(:wind_mph)

    expect(forecast).to have_key(:forecast)
    expect(forecast[:forecast]).to have_key(:forecastday)
    expect(forecast[:forecast][:forecastday].first).to have_key(:date)
    expect(forecast[:forecast][:forecastday].first).to have_key(:day)
    expect(forecast[:forecast][:forecastday].first[:day]).to have_key(:maxtemp_f)
    expect(forecast[:forecast][:forecastday].first[:day]).to have_key(:mintemp_f)
    expect(forecast[:forecast][:forecastday].first[:day]).to have_key(:condition)
    expect(forecast[:forecast][:forecastday].first[:day][:condition]).to have_key(:text)
  end
end