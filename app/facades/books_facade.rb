class BooksFacade
  def initialize(location, service = BookService.new)
    @location = location
    @service = service
    @books = nil
  end

  def forecast
    @forecast ||= begin
      forecast_json = @forecast_service.get_forecast(@location)
      @fore
    end
  end
end