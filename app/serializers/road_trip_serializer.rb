class RoadTripSerializer
  def initialize(route_info, forecast)
    @route_info = route_info
    @forecast = forecast
  end

  def serialize
    {
      data: {
        id: "null",
        type: "road_trip",
        attributes: {
          start_city: @route_info[:start_city].gsub(",", ", "),
          end_city: @route_info[:end_city].gsub(",", ", "),
          travel_time: @route_info[:travel_time],
          weather_at_eta: {
            datetime: @forecast[:datetime],
            temperature: @forecast[:temperature],
            condition: @forecast[:condition]
          }
        }
      }
    }
  end
end
