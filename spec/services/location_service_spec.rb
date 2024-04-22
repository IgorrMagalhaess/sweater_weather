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
end