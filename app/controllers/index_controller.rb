include Geokit::Geocoders

class IndexController < ApplicationController
  def index
    australia = GoogleGeocoder.geocode("Australia")

    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init([australia.lat,australia.lng],5)


    routes = []
    routes <<
      ["Melbourne Australia", "North Shore, Geelong Australia", "Ararat Australia",
      "Stawell Australia", "Dimboola Australia", "Nhill Australia", "Bordertown Australia",
      "Murray Bridge Australia", "Adelaide Australia"]
    routes << 
      ["Sydney Australia", "Broken Hill Australia", "Adelaide Australia",
      "Cook South Australia", "Kalgoorlie Australia", "Perth Australia"]
    routes <<
      ["Darwin Australia", "Katherine Australia", "Alice Springs Australia", "Adelaide Australia"]
    routes <<
      ["Perth Australia","Armadale WA Australia","Byford WA Australia","Mundijong WA Australia",
      "Serpentine WA Australia", "North Dandalup WA Australia", "Pinjarra WA Australia", "Waroona WA Australia",
      "Yarloop WA Australia","Cookernup WA Australia","Harvey WA Australia" ,"Brunswick WA Australia",
      "Bunbury WA Australia"]
    routes << 
      ["Perth WA Australia","Midland WA Australia","Toodyay WA Australia",
      "Northam WA Australia","Meckering WA Australia", "Cunderdin WA Australia",
      "Tammin WA Australia","Kellerberrin WA Australia","Doodlakine WA Australia",
      "Hines Hill WA Australia","Merredin WA Australia", "BURRACOPPIN WA Australia",
      "CARRABIN WA Australia", "BODALLIN WA Australia", "MOORINE RK WA Australia",
      "SOUTHERN CROSS WA Australia", "KOOLYANOBBING WA Australia", "BONNIE VALE WA Australia",
      "KALGOORLIE WA Australia"]
    routes <<
      ["Normanton QLD Australia", "Croydon QLD Australia"]
    routes <<
      [
        "Townsville QLD Australia", "Charters Towers QLD Australia", "Pentland QLD Australia",
        "Torrens Creek QLD Australia", "Hughenden QLD Australia", "Richmond QLD Australia",
        "Julia Creek QLD Australia", "Cloncurry QLD Australia", "Duchess QLD Australia",
        "Mount Isa QLD Australia"]
    routes <<
      ["Cairns QLD Australia", "Freshwater QLD Australia", "Kuranda QLD Australia"]
    routes <<
      ["Cairns QLD Australia", "Mareeba QLD Australia", "Almaden QLD Australia",
      "Mount Surprise QLD Australia", "Einasleigh QLD Australia", "Forsayth QLD Australia"]
    routes <<
      ["Longreach QLD Australia", "Ilfracombe QLD Australia", "Barcaldine QLD Australia",
      "Jericho QLD Australia", "Alpha QLD Australia",	"Bogantungan QLD Australia",
      "Willows QLD Australia", "Anakie QLD Australia",  "Emerald QLD Australia",
      "Comet QLD Australia", "Blackwater QLD Australia", "Bluff QLD Australia",
      "Dingo QLD Australia", "Duaringa QLD Australia", "Rockhampton QLD Australia",
      "Mount Larcom QLD Australia", "Gladstone QLD Australia", "Miriam Vale QLD Australia",
      "Bundaberg QLD Australia", "Maryborough West QLD Australia", "Gympie North QLD Australia",
      "Cooroy QLD Australia", "Nambour QLD Australia", "Caboolture QLD Australia",
      "Brisbane QLD Australia"]

    routes.each do |route|
      stops = get_stops_from_route route

      add_waypoints_to_map @map, stops, :end

      @map.overlay_init(GPolyline.new get_track_line_from_stops(stops),"#ff0000",3,1.0)
    end
  end

  private
  def add_waypoints_to_map map, stops, markers
    case markers
    when :all then
      stops.each do |stop|
        map.overlay_init(GMarker.new([stop.lat,stop.lng],:title => stop.city, :info_window =>stop.city))
      end
    when :end then
      map.overlay_init(GMarker.new([stops.first.lat,stops.first.lng],:title => stops.first.city, :info_window =>stops.first.city))
      map.overlay_init(GMarker.new([stops.last.lat,stops.last.lng],:title => stops.last.city, :info_window =>stops.last.city))
    else
      #show no end points
    end
  end

  def get_stops_from_route route
    stops = []
    route.each do |stop|
      stops << GoogleGeocoder.geocode(stop.to_s)
    end

    stops
  end

  def get_track_line_from_stops stops
    points = []
    stops.each do |stop|
      points << [stop.lat, stop.lng]
    end

    points
  end
end
