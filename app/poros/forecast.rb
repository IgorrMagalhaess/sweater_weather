class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :resumed_forecast

  def initialize(forecast_data)
    @current_weather = current_weather_data(forecast_data[:current])
    @daily_weather = daily_weather_data(forecast_data[:forecast][:forecastday])
    @hourly_weather = hourly_weather_data(forecast_data[:forecast][:forecastday].first[:hour])
    @resumed_forecast = resumed_forecast_data(forecast_data)
  end

  def current_weather_data(weather_data)
    {
      last_updated: weather_data[:last_updated],
      temperature: weather_data[:temp_f],
      feels_like: weather_data[:feelslike_f],
      humidity: weather_data[:humidity],
      uvi: weather_data[:uv],
      visibility: weather_data[:vis_miles],
      condition: weather_data[:condition][:text],
      icon: weather_data[:condition][:icon]
    }
  end

  def daily_weather_data(weather_data)
    weather_data.map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather_data(weather_data)
    weather_data.map do |day|
      {
        time: day[:time].split(' ')[1],
        temperature: day[:temp_f],
        condition: day[:condition][:text],
        icon: day[:condition][:icon]
      }
    end
  end

  def resumed_forecast_data(forecast_data)
    {
      summary: forecast_data[:current][:condition][:text],
      temperature: forecast_data[:current][:temp_f]
    }
  end
end