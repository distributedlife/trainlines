include Geokit::Geocoders

class IndexController < ApplicationController
  def index
    @geocoded_routes = []
    @used_stations = {}
    Routes.all.each do |route|
      @geocoded_routes << get_stops_from_route(route)
    end
  end

  private
  def get_stops_from_route route
    stops = []
    Stops.where(:routes_id => route.id).each do |stop|
      
      location = Location.where(:name => stop.name)
      if location.empty?
        geo = GoogleGeocoder.geocode(stop.name)
        
        Location.create(:name => stop.name, :lat => geo.lat, :lng => geo.lng)
        
        stops << [geo.lat, geo.lng]
        sleep 0.1

        @used_stations[stop.name] = true
      else
        if @used_stations[stop.name].nil?
          stops << [location.first.lat, location.first.lng, true, location.first.name]
          
          @used_stations[stop.name] = true
        else
          stops << [location.first.lat, location.first.lng, false, ""]
        end
      end
    end

    stops
  end
end
