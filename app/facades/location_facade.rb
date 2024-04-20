class LocationFacade 
  def initialize(location, service = LocationService.new)
    @location = location
    @service = service
    @coordinates = nil
  end

  def coordinates
    @coordinates ||= begin
      coordinates_json = @service.get_coordinates(@location)
      @coordinates = coordinates_json[:results].first[:locations].first[:latLng]
    end
  end
end