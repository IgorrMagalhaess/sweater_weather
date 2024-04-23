class LocationService
  def conn
    conn = Faraday.new("https://www.mapquestapi.com/geocoding") do |f|
      f.headers["Accept"] = "application/json"
    end
  end

  def get_url(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_coordinates(location)
    get_url("https://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquestapi_key}&location=#{location}")
  end

  def get_route_info(start_city, end_city)
    get_url("https://www.mapquestapi.com/directions/v2/route?key=#{Rails.application.credentials.mapquestapi_key}&from=#{start_city}&to=#{end_city}")
  end
end