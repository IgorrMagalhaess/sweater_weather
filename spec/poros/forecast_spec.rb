require "rails_helper"

RSpec.describe Forecast do
  before(:each) do
    @forecast_data = {
      current: {
        last_updated: '2024-04-21 15:00',
        temp_f: 75,
        feelslike_f: 78,
        humidity: 60,
        uv: 3,
        vis_miles: 10,
        condition: { text: 'Sunny', icon: '01d' }
      },
      forecast: {
        forecastday: [{
          date: '2024-04-21',
          astro: { sunrise: '06:00', sunset: '18:00' },
          day: { maxtemp_f: 80, mintemp_f: 70, condition: { text: 'Partly cloudy', icon: '02d' } },
          hour: [{
            time: '2024-04-21 12:00',
            temp_f: 77,
            condition: { text: 'Cloudy', icon: '04d' }
          }]
        }]
      }
    }

    @forecast = Forecast.new(@forecast_data)
  end

  describe '#initialize' do
    it 'correctly initializes current_weather, daily_weather, and hourly_weather' do
      expect(@forecast.current_weather[:last_updated]).to eq('2024-04-21 15:00')
      expect(@forecast.daily_weather.first[:date]).to eq('2024-04-21')
      expect(@forecast.hourly_weather.first[:time]).to eq('12:00')
    end
  end

  describe '#current_weather_data' do
    it 'returns a hash with current weather data' do
      current_weather = @forecast.current_weather

      expect(current_weather[:last_updated]).to eq('2024-04-21 15:00')
      expect(current_weather[:condition]).to eq('Sunny')
    end
  end

  describe '#daily_weather_data' do
    it 'returns an array of hashes with daily weather data' do
      daily_weather = @forecast.daily_weather

      expect(daily_weather.first[:date]).to eq('2024-04-21')
      expect(daily_weather.first[:condition]).to eq('Partly cloudy')
    end
  end

  describe '#hourly_weather_data' do
    it 'returns an array of hashes with hourly weather data' do
      hourly_weather = @forecast.hourly_weather

      expect(hourly_weather.first[:time]).to eq('12:00')
      expect(hourly_weather.first[:condition]).to eq('Cloudy')
    end
  end
end
