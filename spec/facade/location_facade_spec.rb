require "rails_helper"

RSpec.describe LocationFacade do
  describe '#initialize' do
    it 'creates a LocationFacade object', :vcr do
      facade = LocationFacade.new('New York, NY')

      expect(facade).to be_an_instance_of(LocationFacade)
    end
  end

  describe '#coordinates' do
    it 'calls get_coordinates on service and returns a hash with latitude and longitude', :vcr do
      facade = LocationFacade.new('New York')

      coordinates = facade.coordinates

      expect(coordinates).to be_a(Hash)
      expect(coordinates[:lat]).to be_a(Float)
      expect(coordinates[:lng]).to be_a(Float)
    end
  end 
end
