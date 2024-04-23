class RoadTripSerializer
  def initialize(start_city, end_city, route_info, forecast)
    @start_city = start_city
    @end_city = end_city
    @route_info = route_info
    @forecast = forecast
  end

  def serialize
    {
      data: {
        id: "null",
        type: "road_trip",
        attributes: {
          start_city: @start_city,
          end_city: @end_city,
          travel_time: @route_info[:travel_time],
          weather_at_eta: serialize_weather_at_eta
        }
      }
    }
  end

  private

  def serialize_weather_at_eta
    if @forecast[:datetime].present?
      {
        datetime: @forecast[:datetime],
        temperature: @forecast[:temperature],
        condition: @forecast[:condition]
      }
    else
      {
        
      }
    end
  end
end
