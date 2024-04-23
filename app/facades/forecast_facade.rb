require 'time'

class ForecastFacade
  def initialize(coordinates, travel_time = nil, service = ForecastService.new)
    @coordinates = coordinates
    @travel_time = travel_time
    @service = service
    @forecast = nil
  end

  def forecast
    @forecast ||= begin
      forecast_json = @service.get_forecast(@coordinates)
      @forecast = Forecast.new(forecast_json)
    end
  end

  def forecast_end_route
    @forecast_end_route ||= begin
      forecast_end_route_json = @service.get_forecast(@coordinates)
      if @travel_time == "impossible"
        @forecast_end_route = {}
      else
        time_end_route = calculate_time_at_arrival
        forecast_hour = forecast_end_route_json[:forecast][:forecastday].find do |day|
          day[:date] == time_end_route[:date]
        end&.dig(:hour)&.find { |hour| hour[:time] == time_end_route[:time] }

        if forecast_hour
          @forecast_end_route = {
            datetime: forecast_hour[:time],
            temperature: forecast_hour[:temp_f],
            condition: forecast_hour[:condition][:text]
          }
        end
    
        @forecast_end_route
      end
    end
  end

  private
  def calculate_time_at_arrival
    current_time = Time.now
    travel_time = @travel_time.split(':').map(&:to_i)
    travel_duration_seconds = travel_time[0] * 3600 + travel_time[1] * 60 + travel_time[2]

    time_end_route = current_time + travel_duration_seconds
    { date: time_end_route.strftime("%Y-%m-%d"),
      time: Time.at((time_end_route.to_i / 3600) * 3600).strftime("%Y-%m-%d %H:%M") }
  end
end