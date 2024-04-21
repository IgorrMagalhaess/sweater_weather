class ForecastFacade
  def initialize(coordinates, service = ForecastService.new)
    @coordinates = coordinates
    @service = service
    @forecast = nil
  end

  def forecast
    @forecast ||= begin
      forecast_json = @service.get_forecast(@coordinates)
      @forecast = Forecast.new(forecast_json)
    end
  end
end