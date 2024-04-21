class ForecastService
  def conn
    conn = Faraday.new("http://api.weatherapi.com/") do |f|
      f.headers["Accept"] = "application/json"
    end
  end

  def get_url(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_forecast(coordinates)
    get_url("http://api.weatherapi.com/v1/forecast.json?key=#{Rails.application.credentials.weatherapi_key}&q=#{coordinates}&days=5")
  end
end