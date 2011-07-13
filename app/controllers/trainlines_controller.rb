include Geokit::Geocoders

class TrainlinesController < ApplicationController
  def new
    @geocoded_routes = []
    @stops = ""
  end

  def edit
    @used_stations = {}
    @geocoded_routes = []

    @route = Routes.find(params[:id])
    if @route.nil?
      return redirect_to root_path
    end


    @geocoded_routes << get_stops_from_route(@route)


    stops = []
    Stops.where(:routes_id => @route.id).each do |stop|
      stops << stop.name
    end
    @stops = stops.join("\n")
    @name = @route.name
  end

  def update
    stops = []
    changed ||= true
    changed = false if params[:changed] == "false"
    @name = params[:name]
    @name = "" if @name == "a name for your route..."

    stops = get_collapsed_array_from_stop_string params[:stops]
    stops.flatten!


    @route = Routes.find(params[:id])
    if @route.nil?
      return redirect_to root_path
    end

    if !changed and !@name.empty?
      @route.name = @name
      @route.save!

      #remove old stops (they will be replaced by new ones)
      Stops.where(:routes_id => @route.id).each do |stop|
        stop.delete
      end

      redirect_to trainline_path(@route.id)
    end


    #trim and geocode
    @geocoded_routes = []
    @used_stations = {}
    geocoded_stops = []
    stops.each do |stop|
      stop.strip!

      geocoded_stops << get_location(stop)

      if !changed and !@name.empty?
        Stops.create(:name => stop, :routes_id => @route.id)
      end
    end
    @geocoded_routes << geocoded_stops

    @stops = stops.join("\n")
    @changed = false
  end

  def create
    stops = []
    changed ||= true
    changed = false if params[:changed] == "false" 
    @name = params[:name]
    @name = "" if @name == "a name for your route..."

    stops = get_collapsed_array_from_stop_string params[:stops]
    stops.flatten!


    if !changed and !@name.empty?
      route = Routes.create(:name => @name)

      redirect_to root_path
    end


    #trim and geocode
    @geocoded_routes = []
    @used_stations = {}
    geocoded_stops = []
    stops.each do |stop|
      stop.strip!

      geocoded_stops << get_location(stop)

      if !changed and !@name.empty?
        Stops.create(:name => stop, :routes_id => route.id)
      end
    end
    @geocoded_routes << geocoded_stops

    @stops = stops.join("\n")
    @changed = false
  end
  
  def index
    @geocoded_routes = []
    @used_stations = {}
    Routes.all.each do |route|
      @geocoded_routes << get_stops_from_route(route)
    end
  end

  def routes
    @routes = Routes.order(:name).all
  end

  def show
    @used_stations = {}
    @geocoded_routes = []

    @route = Routes.find(params[:id])
    @geocoded_routes << get_stops_from_route(@route)

    redirect_to root_path if @route.nil?
  end

  private
  def get_collapsed_array_from_stop_string stops_string
    stops = []
    comma_list = stops_string.split(',')
    comma_list.each do |item|
      stops << item.split("\r\n")
    end

    stops
  end

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
