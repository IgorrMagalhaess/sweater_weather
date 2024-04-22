# class AirQualityFacade
#   def initialize(lat, lon, service = AirQualityService.new)
#     @lat = lat
#     @lon = lon
#     @service = service
#     @air_quality = nil
#   end

#   def air_quality
#     @air_quality ||= begin
#       air_quality_json = @service.get_air_quality(@lat, @lon)
#       require 'pry' ; binding.pry
#     end
#   end
# end