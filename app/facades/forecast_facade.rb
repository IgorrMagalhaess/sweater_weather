class ForecastFacade
  def initialize(coordinates, service = ForecastService.new)
    @coordinates = coordinates
    @service = service
    @forecast = nil
  end

  def forecast
    @forecast ||= begin
      forecast_json = @service.get_forecast(@coordinates)
      @forecast = forecast_json.map { |forecast_data| Forecast.new(forecast_data)}
    end
  end
end