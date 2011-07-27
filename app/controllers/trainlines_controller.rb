include Geokit::Geocoders

class TrainlinesController < ApplicationController
  caches_page :index, :show, :routes, :search

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

      expire_page(:controller => 'trainlines', :action => 'index')
      expire_page(:controller => 'trainlines', :action => 'search')
      expire_page(:controller => 'trainlines', :action => 'routes')
      expire_page(:controller => 'trainlines', :action => 'show', :id => params[:id])
      redirect_to trainline_path(@route.id)
    end


    #trim and geocode
    @geocoded_routes = []
    @used_stations = {}
    geocoded_stops = []
    stops.each do |stop|
      stop.strip!

      next if stop.empty?

      pass_through = !stop["*"].nil?
      stop = stop.gsub("*", "")

      geocoded_stops << get_location(stop, pass_through)

      if !changed and !@name.empty?
        Stops.create(:name => stop, :routes_id => @route.id, :pass_through => pass_through)
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

      expire_page(:controller => 'trainlines', :action => 'index')
      expire_page(:controller => 'trainlines', :action => 'search')
      redirect_to root_path
    end


    #trim and geocode
    @geocoded_routes = []
    @used_stations = {}
    geocoded_stops = []
    stops.each do |stop|
      stop.strip!

      next if stop.empty?

      pass_through = !stop["*"].nil?
      stop = stop.gsub("*", "")

      geocoded_stops << get_location(stop, pass_through)

      if !changed and !@name.empty?
        Stops.create(:name => stop, :routes_id => route.id, :pass_through => pass_through)
      end
    end
    @geocoded_routes << geocoded_stops

    @stops = stops.join("\n")
    @changed = false
  end
  
  def index
#    response.headers['Cache-Control'] = 'public, max-age=300'

    recent_route = Routes.order(:updated_at).first
    if stale?(:last_modified => recent_route.updated_at, :etag => recent_route.updated_at)
      @geocoded_routes = []
      @used_stations = {}
      Routes.where(:discontinued => nil).each do |route|
        @geocoded_routes << get_stops_from_route(route)
      end
    end
  end

  def routes
    @routes = Routes.order("discontinued DESC").order(:name).all

    sql = <<-SQL
      select routes_id, count(*) as stops
      from stops
      group by routes_id
    SQL

    @route_stops = Stops.find_by_sql(sql)
  end

  def show
    @used_stations = {}
    @geocoded_routes = []

    @route = Routes.find(params[:id])
    @geocoded_routes << get_stops_from_route(@route)

    redirect_to root_path if @route.nil?
  end

  def discontinue
    @route = Routes.find(params[:id])
    @route.discontinued = Time.now
    @route.save

    redirect_to trainline_path(@route.id)
  end

  def reinstate
    @route = Routes.find(params[:id])
    @route.discontinued = nil
    @route.save

    redirect_to trainline_path(@route.id)
  end

  def search
    @q = params[:q]
    @q.strip!
    @q.downcase!

    sql = <<-SQL
      select *
      from routes
      where (lower(routes.name) like '%#{@q}%'
      or routes.id in (select routes_id from stops where lower(stops.name) like '%#{@q}%'))
      and routes.discontinued is null
    SQL

    @geocoded_routes = []
    @used_stations = {}
    Routes.find_by_sql(sql).each do |route|
      @geocoded_routes << get_stops_from_route(route)
    end
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
      stops << get_location(stop.name, stop.pass_through)
    end

    stops
  end

  def get_location name, pass_through
    location = Location.where(:name => name)
    if location.empty?
      geo = GoogleGeocoder.geocode(name)

      Location.create(:name => name, :lat => geo.lat, :lng => geo.lng)

      @used_stations[name] = true
      sleep 0.1

      return [geo.lat, geo.lng, !pass_through, name]
    else
      if @used_stations[name].nil?
        @used_stations[name] = true

        return [location.first.lat, location.first.lng, !pass_through, location.first.name]
      else
        return [location.first.lat, location.first.lng, false, ""]
      end
    end
  end
end
