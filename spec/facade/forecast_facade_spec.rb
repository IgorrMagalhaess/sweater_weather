require "rails_helper"

RSpec.describe ForecastFacade do
  describe '#initialize' do
    it 'creates a ForecastFacade object', :vcr do
      facade = ForecastFacade.new("40.7128, -74.0060")

      expect(facade).to be_an_instance_of(ForecastFacade)
    end
  end

  describe '#weather_forecast' do
    it 'calls get_weather_forecast on service and returns a Forecast object', :vcr do
      facade = ForecastFacade.new("40.7128, -74.0060")

      weather_forecast = facade.forecast

      expect(weather_forecast).to be_an_instance_of(Forecast)
      expect(weather_forecast.current_weather).to be_a Hash
      expect(weather_forecast.daily_weather).to be_an(Array)
      expect(weather_forecast.hourly_weather).to be_an(Array)
    end
  end 
end
