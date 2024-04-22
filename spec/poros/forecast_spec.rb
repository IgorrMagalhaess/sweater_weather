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
    it 'correctly initializes current_weather, daily_weather, hourly_weather, and resumed_forecast' do
      expect(@forecast.current_weather[:last_updated]).to eq('2024-04-21 15:00')
      expect(@forecast.daily_weather.first[:date]).to eq('2024-04-21')
      expect(@forecast.hourly_weather.first[:time]).to eq('12:00')
      expect(@forecast.resumed_forecast[:summary]).to eq('Sunny')
      expect(@forecast.resumed_forecast[:temperature]).to eq(75)
    end
  end

  describe '#current_weather_data' do
    it 'returns a hash with current weather data' do
      current_weather = @forecast.current_weather

      expect(current_weather[:last_updated]).to eq('2024-04-21 15:00')
      expect(current_weather[:temperature]).to eq(75)
      expect(current_weather[:feels_like]).to eq(78)
      expect(current_weather[:humidity]).to eq(60)
      expect(current_weather[:uvi]).to eq(3)
      expect(current_weather[:visibility]).to eq(10)
      expect(current_weather[:condition]).to eq('Sunny')
      expect(current_weather[:icon]).to eq('01d')
    end
  end

  describe '#daily_weather_data' do
    it 'returns an array of hashes with daily weather data' do
      daily_weather = @forecast.daily_weather

      expect(daily_weather.first[:date]).to eq('2024-04-21')
      expect(daily_weather.first[:sunrise]).to eq('06:00')
      expect(daily_weather.first[:sunset]).to eq('18:00')
      expect(daily_weather.first[:max_temp]).to eq(80)
      expect(daily_weather.first[:min_temp]).to eq(70)
      expect(daily_weather.first[:condition]).to eq('Partly cloudy')
      expect(daily_weather.first[:icon]).to eq('02d')
    end
  end

  describe '#hourly_weather_data' do
    it 'returns an array of hashes with hourly weather data' do
      hourly_weather = @forecast.hourly_weather

      expect(hourly_weather.first[:time]).to eq('12:00')
      expect(hourly_weather.first[:temperature]).to eq(77)
      expect(hourly_weather.first[:condition]).to eq('Cloudy')
      expect(hourly_weather.first[:icon]).to eq('04d')
    end
  end
end
