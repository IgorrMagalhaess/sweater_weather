class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(forecast_data)
    @current_weather = current_weather(forecast_data)
    @daily_weather = daily_weather(forecast_data)
    @hourly_weather = hourly_weather(forecast_data)
  end

  def current_weather(weather_data)
      {
        last_updated: weather_data[:current][:last_updated],
        temperature: weather_data[:current][:temp_f],
        feels_like: weather_data[:current][:feelslike_f],
        humidity: weather_data[:current][:humidity],
        uvi: weather_data[:current][:uv],
        visibility: weather_data[:current][:vis_miles],
        condition: weather_data[:current][:condition][:text],
        icon: weather_data[:current][:condition][:icon]
      }
  end

  def daily_weather(weather_data)
    weather_data[:forecast][:forecastday].map do |day|
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

  def hourly_weather(weather_data)
    weather_data[:forecast][:forecastday].first[:hour].map do |day|
      {
        time: day[:time].split(' ')[1],
        temperature: day[:temp_f],
        condition: day[:condition][:text],
        icon: day[:condition][:icon]
      }
    end
  end
end