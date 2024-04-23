require "rails_helper"

RSpec.describe LocationService do
  describe "get coordinates" do
    it 'returns coordinates for the location', :vcr do
      coordinates = LocationService.new.get_coordinates("Atlanta, GA")

      expect(coordinates).to be_a(Hash)
      expect(coordinates).to have_key(:results)
      expect(coordinates[:results].first[:locations].first[:latLng]).to be_a(Hash)
      expect(coordinates[:results].first[:locations].first[:latLng].values).to eq([33.74831, -84.39111])
    end
  end

  describe "get_route_info" do
    it 'returns route information for the given start and end cities', :vcr do
      route_info = LocationService.new.get_route_info("New York", "Los Angeles")

      expect(route_info).to be_a(Hash)
      expect(route_info).to have_key(:route)
      expect(route_info[:route]).to have_key(:formattedTime)
      expect(route_info[:route][:formattedTime]).to be_a(String)
    end
  end
end