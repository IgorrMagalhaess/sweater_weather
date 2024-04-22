# require "rails_helper"

# RSpec.describe AirQualityFacade do
#   describe "#initialize" do
#     it "creates a new AirQualityFacade object" do
#       air_quality = AirQuality.new(28.63097, 77.2172)

#       expect(air_quality).to be_an_instance_of(AirQualityFacade)
#     end
#   end

#   describe "#air_quality" do
#     it "calls get air quality on service and returns an Air Quality object" do
#       facade = AirQualityFacade.new(28.63097, 77.2172)

#       air_quality = facade.air_quality

#       expect(air_quality).to be_an_instance_of(AirQuality)

#     end
#   end
# end