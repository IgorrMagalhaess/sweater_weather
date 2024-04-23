class RoutesFacade
  def initialize(start_city, end_city, service = LocationService.new)
    @start_city = start_city
    @end_city = end_city
    @service = service
    @route_info = nil
  end

  def route_info
    @route_info ||= begin
      route_json = @service.get_route_info(@start_city, @end_city)
      if route_json[:route][:formattedTime]  
        @route_info = {
          start_city: @start_city,
          end_city: @end_city,
          travel_time: route_json[:route][:formattedTime]
        }
      else
        @route_info = {
          start_city: @start_city,
          end_city: @end_city,
          travel_time: "impossible"
        }
      end
    end
  end
end