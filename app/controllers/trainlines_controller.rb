include Geokit::Geocoders

class TrainlinesController < ApplicationController
  def new
  end

  def create
    stops = []

    comma_list = params[:stops].split(',')
    comma_list.each do |item|
      stops << item.split("\r\n")
    end

    #flatten, trim and geocode
    stops.flatten!

    @geocoded_routes = []
    @used_stations = {}
    geocoded_stops = []
    stops.each do |stop|
      stop.strip!

      geocoded_stops << get_location(stop)
    end
    @geocoded_routes << geocoded_stops

    @stops = stops.join(',')
  end
  
  def show
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
      stops << get_location(stop.name)
    end

    stops
  end

  def get_location name
    location = Location.where(:name => name)
    if location.empty?
      geo = GoogleGeocoder.geocode(name)

      Location.create(:name => name, :lat => geo.lat, :lng => geo.lng)

      @used_stations[name] = true
      sleep 0.1

      return [geo.lat, geo.lng, true, name]
    else
      if @used_stations[name].nil?
        @used_stations[name] = true

        return [location.first.lat, location.first.lng, true, location.first.name]
      else
        return [location.first.lat, location.first.lng, false, ""]
      end
    end
  end
end
