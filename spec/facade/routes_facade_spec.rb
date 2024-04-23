require "rails_helper"

RSpec.describe RoutesFacade do
  describe '#initialize' do
    it 'creates a RoutesFacade object', :vcr do
      facade = RoutesFacade.new("New York", "Los Angeles")

      expect(facade).to be_an_instance_of(RoutesFacade)
    end
  end

  describe '#route_info' do
    it 'calls get_route_info on service and returns route information', :vcr do
      facade = RoutesFacade.new("New York", "Los Angeles")

      route_info = facade.route_info

      expect(route_info).to be_a(Hash)
      expect(route_info[:start_city]).to eq("New York")
      expect(route_info[:end_city]).to eq("Los Angeles")
      expect(route_info[:travel_time]).to be_a(String)
    end

    it 'gets impossible route information if route is impossible', :vcr do
      facade = RoutesFacade.new("New York", "London")

      route_info = facade.route_info

      expect(route_info).to be_a(Hash)
      expect(route_info[:start_city]).to eq("New York")
      expect(route_info[:end_city]).to eq("London")
      expect(route_info[:travel_time]).to eq("impossible")
    end
  end
end
