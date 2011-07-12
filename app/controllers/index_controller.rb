include Geokit::Geocoders

class IndexController < ApplicationController
  def index
#    routes = []
#    routes <<
#      ["Southern Cross Station Melbourne VIC Australia",
#      "North Shore VIC Australia",
#      "Geelong Australia",
#      "Ararat Australia",
#      "Stawell Australia",
#      "Dimboola Australia",
#      "Nhill Australia",
#      "Bordertown Australia",
#      "Murray Bridge Australia",
#      "Adelaide Australia"]
#
#    routes <<
#      ["Sydney Australia", "Broken Hill Australia", "Adelaide Australia",
#      "Cook South Australia", "Kalgoorlie Australia", "Perth Australia"]
#    routes <<
#      ["Darwin Australia", "Katherine Australia", "Alice Springs Australia", "Adelaide Australia"]
#    routes <<
#      ["Perth Australia","Armadale WA Australia","Byford WA Australia","Mundijong WA Australia",
#      "Serpentine WA Australia", "North Dandalup WA Australia", "Pinjarra WA Australia", "Waroona WA Australia",
#      "Yarloop WA Australia","Cookernup WA Australia","Harvey WA Australia" ,"Brunswick WA Australia",
#      "Bunbury WA Australia"]
#    routes <<
#      ["Perth WA Australia","Midland WA Australia","Toodyay WA Australia",
#      "Northam WA Australia","Meckering WA Australia", "Cunderdin WA Australia",
#      "Tammin WA Australia","Kellerberrin WA Australia","Doodlakine WA Australia",
#      "Hines Hill WA Australia","Merredin WA Australia", "BURRACOPPIN WA Australia",
#      "CARRABIN WA Australia", "BODALLIN WA Australia", "MOORINE RK WA Australia",
#      "SOUTHERN CROSS WA Australia", "KOOLYANOBBING WA Australia", "BONNIE VALE WA Australia",
#      "KALGOORLIE WA Australia"]
#    routes <<
#      ["Normanton QLD Australia", "Croydon QLD Australia"]
#    routes <<
#      [
#        "Townsville QLD Australia", "Charters Towers QLD Australia", "Pentland QLD Australia",
#        "Torrens Creek QLD Australia", "Hughenden QLD Australia", "Richmond QLD Australia",
#        "Julia Creek QLD Australia", "Cloncurry QLD Australia", "Duchess QLD Australia",
#        "Mount Isa QLD Australia"]
#    routes <<
#      ["Cairns QLD Australia", "Freshwater QLD Australia", "Kuranda QLD Australia"]
#    routes <<
#      ["Cairns QLD Australia", "Mareeba QLD Australia", "Almaden QLD Australia",
#      "Mount Surprise QLD Australia", "Einasleigh QLD Australia", "Forsayth QLD Australia"]
#    routes <<
#      ["Longreach QLD Australia", "Ilfracombe QLD Australia", "Barcaldine QLD Australia",
#      "Jericho QLD Australia", "Alpha QLD Australia",	"Bogantungan QLD Australia",
#      "Willows QLD Australia", "Anakie QLD Australia",  "Emerald QLD Australia",
#      "Comet QLD Australia", "Blackwater QLD Australia", "Bluff QLD Australia",
#      "Dingo QLD Australia", "Duaringa QLD Australia", "Rockhampton QLD Australia",
#      "Mount Larcom QLD Australia", "Gladstone QLD Australia", "Miriam Vale QLD Australia",
#      "Bundaberg QLD Australia", "Maryborough West QLD Australia", "Gympie North QLD Australia",
#      "Cooroy QLD Australia", "Nambour QLD Australia", "Caboolture QLD Australia",
#      "Brisbane QLD Australia"]
#    routes <<
#      ["Rockhampton QLD Australia", "St Lawrence QLD Australia",	"Sarina QLD Australia",
#      "Mackay QLD Australia", "Proserpine QLD Australia","Bowen QLD Australia",
#      "Home Hill QLD Australia", "Ayr QLD Australia",	"Giru QLD Australia",
#      "Townsville QLD Australia",	"Ingham QLD Australia",	"Cardwell QLD Australia",
#      "Tully QLD Australia", "Innisfail QLD Australia",	"Babinda QLD Australia",
#      "Gordonvale QLD Australia",	"Cairns QLD Australia"]
#    routes <<
#      ["Charleville QLD Australia", "Morven QLD Australia",	"Mitchell QLD Australia",
#      "Roma QLD Australia",	"Wallumbilla QLD Australia", "Yuleba QLD Australia",
#      "Miles QLD Australia", "Chinchilla QLD Australia", "Dalby QLD Australia",
#      "Oakey QLD Australia", "Toowoomba QLD Australia",	"Helidon QLD Australia",
#      "Gatton QLD Australia", "Laidley QLD Australia", "Rosewood QLD Australia",
#      "Ipswich QLD Australia", "Corinda QLD Australia",	"Brisbane QLD Australia",]
#    routes <<
#      ["Sydney NSW Australia", "Strathfield NSW Australia", "Hornsby NSW Australia",
#      "Gosford NSW Australia", "Wyong NSW Australia", "Fassifern NSW Australia",
#      "Broadmeadow NSW Australia", "Maitland NSW Australia", "Dungong NSW Australia",
#      "Gloucester NSW Australia", "Wingham NSW Australia", "Taree NSW Australia",
#      "Kendall NSW Australia", "Wauchope NSW Australia", "Kempsey NSW Australia",
#      "Eungai NSW Australia", "Macksville NSW Australia", "Nambucca Heads NSW Australia",
#      "Urunga NSW Australia", "Sawtell NSW Australia", "Coffs Harbour NSW Australia",
#      "Grafton NSW Australia", "Casino NSW Australia", "Kyogle NSW Australia",
#      "Brisbane QLD Australia"]
#
#    routes <<
#      ["Maitland NSW Australia",
#      "Singleton NSW Australia",
#      "Muswellbrook NSW Australia",
#      "Aberdeen NSW Australia",
#      "Scone NSW Australia",
#      "Murrurundi NSW Australia",
#      "Willow Tree NSW Australia",
#      "Quirindi NSW Australia",
#      "Werris Creek NSW Australia",
#      "Tamworth NSW Australia",
#      "Kootingal NSW Australia",
#      "Walcha Road NSW Australia",
#      "Uralla NSW Australia",
#      "Armidale NSW Australia"]
#
#    routes <<
#      ["Werris Creek NSW Australia",
#      "Gunnedah NSW Australia",
#      "Boggabri NSW Australia",
#      "Narrabri NSW Australia",
#      "Bellata NSW Australia",
#      "Moree NSW Australia"]
#
#    routes <<
#      ["Strathfield NSW Australia",
#      "Campbelltown NSW Australia",
#      "Mittagong NSW Australia",
#      "Bowral NSW Australia",
#      "Moss Vale NSW Australia",
#      "Bundanoon NSW Australia",
#      "Goulburn NSW Australia",
#      "Tarago NSW Australia",
#      "Bungendore NSW Australia",
#      "Queenbeyan NSW Australia",
#      "Canberra NSW Australia"]
#
#    routes <<
#      ["Goulburn NSW Australia",
#      "Gunning NSW Australia",
#      "Yass Junction NSW Australia",
#      "Harden NSW Australia",
#      "Cootamundra NSW Australia",
#      "Junee NSW Australia",
#      "Wagga Wagga NSW Australia",
#      "The Rock NSW Australia",
#      "Henty NSW Australia",
#      "Culcairn NSW Australia",
#      "Albury NSW Australia"]
#
#    routes <<
#      ["Junee NSW Australia",
#      "Coolamom NSW Australia",
#      "Narrandera NSW Australia",
#      "Leeton NSW Australia",
#      "Griffith NSW Australia"]
#
#    routes <<
#      ["Strathfield NSW Australia",
#      "Parramatta NSW Australia",
#      "Blacktown NSW Australia",
#      "Penrith NSW Australia",
#      "Katoomba NSW Australia",
#      "Mt Victoria NSW Australia",
#      "Lithgow NSW Australia",
#      "Rydal NSW Australia",
#      "Tarana NSW Australia",
#      "Bathurst NSW Australia",
#      "Blayney NSW Australia",
#      "Orange NSW Australia",
#      "Stuart Town NSW Australia",
#      "Wellington NSW Australia",
#      "Geurie NSW Australia",
#      "Dubbo NSW Australia"]
#
#    routes <<
#      ["Orange NSW Australia",
#      "Parkes NSW Australia",
#      "Condobolin NSW Australia",
#      "Euabalong West NSW Australia",
#      "Ivanhoe NSW Australia",
#      "Darnick NSW Australia",
#      "Menindee NSW Australia",
#      "Broken Hill NSW Australia"]
#
#    routes <<
#      ["Southern Cross Station Melbourne VIC Australia",
#      "North Melbourne VIC Australia",
#      "Footscray VIC Australia",
#      "Newport VIC Australia",
#      "Werribee VIC Australia",
#      "Little River VIC Australia",
#      "Lara VIC Australia",
#      "Corio VIC Australia",
#      "North Shore VIC Australia",
#      "North Geelong VIC Australia",
#      "Geelong VIC Australia",
#      "South Geelong VIC Australia",
#      "Marshall VIC Australia",
#      "Winchelsea VIC Australia",
#      "Birregurra VIC Australia",
#      "Colac VIC Australia",
#      "Camperdown VIC Australia",
#      "Terang VIC Australia",
#      "Warrnambool VIC Australia"]
#    routes <<
#      ["Southern Cross Station Melbourne VIC Australia",
#      "North Melbourne VIC Australia",
#      "Footscray VIC Australia",
#      "Sunshine VIC Australia",
#      "Ginifer VIC Australia",
#      "St Albans VIC Australia",
#      "Watergardens VIC Australia",
#      "Diggers Rest VIC Australia",
#      "Sunbury VIC Australia",
#      "Clarkefield VIC Australia",
#      "Riddells Creek VIC Australia",
#      "Gisborne VIC Australia",
#      "Macedon VIC Australia",
#      "Woodend VIC Australia",
#      "Kyneton VIC Australia",
#      "Malmsbury VIC Australia",
#      "Castlemaine VIC Australia",
#      "Kangaroo Flat VIC Australia",
#      "Bendigo VIC Australia",
#      "Eaglehawk VIC Australia",
#      "Dingee VIC Australia",
#      "Pyramid Hill VIC Australia",
#      "Kerang VIC Australia",
#      "Swan Hill VIC Australia"]
#    routes <<
#      ["Bendigo VIC Australia",
#      "Elmore VIC Australia",
#      "Rochester VIC Australia",
#      "Echuca VIC Australia"]
#    routes <<
#      ["Southern Cross Station Melbourne VIC Australia",
#      "North Melbourne VIC Australia",
#      "Footscray VIC Australia",
#      "Sunshine VIC Australia",
#      "Ardeer VIC Australia",
#      "Deer Park VIC Australia",
#      "Rockbank VIC Australia",
#      "Melton VIC Australia",
#      "Baccus Marsh VIC Australia",
#      "Ballan VIC Australia",
#      "Ballarat VIC Australia",
#      "Wendouree VIC Australia",
#      "Beaufort VIC Australia",
#      "Ararat VIC Australia"]
#    routes <<
#      ["Ballarat VIC Australia",
#      "Creswick VIC Australia",
#      "Clunes VIC Australia",
#      "Maryborough VIC Australia"]
#    routes <<
#      ["Southern Cross Station Melbourne VIC Australia",
#      "Flinders Street Station Melbourne VIC Australia",
#      "Richmond VIC Australia",
#      "Caulfield VIC Australia",
#      "Clayton VIC Australia",
#      "Dandenong VIC Australia",
#      "Berwick VIC Australia",
#      "Pakenham VIC Australia",
#      "Nar Nar Goon VIC Australia",
#      "Tynong VIC Australia",
#      "Garfield VIC Australia",
#      "Bunyip VIC Australia",
#      "Longwarry VIC Australia",
#      "Drouin VIC Australia",
#      "Warragal VIC Australia",
#      "Yarragon VIC Australia",
#      "Trafalgar VIC Australia",
#      "Moe VIC Australia",
#      "Traralgon VIC Australia",
#      "Rosedale VIC Australia",
#      "Sale VIC Australia",
#      "Stratford VIC Australia",
#      "Bairnsdale VIC Australia"]
#    routes <<
#      ["Southern Cross Station Melbourne VIC Australia",
#      "North Melbourne VIC Australia",
#      "Essendon VIC Australia",
#      "Broadmeadows VIC Australia",
#      "Craigieburn VIC Australia",
#      "Donnybrook VIC Australia",
#      "Wallan VIC Australia",
#      "Heathcote Junction VIC Australia",
#      "Wandong VIC Australia",
#      "Kilmore East VIC Australia",
#      "Broadford VIC Australia",
#      "Tallarook VIC Australia",
#      "Seymore VIC Australia",
#      "Avenel VIC Australia",
#      "Euroa VIC Australia",
#      "Violet Town VIC Australia",
#      "Benalla VIC Australia",
#      "Wangaratta VIC Australia",
#      "Springhurst VIC Australia",
#      "Chiltern VIC Australia",
#      "Wodonga VIC Australia",
#      "Albury NSW Australia"]
#    routes <<
#      ["Seymore VIC Australia",
#      "Nagamble VIC Australia",
#      "Murchison East VIC Australia",
#      "Mooroopna VIC Australia",
#      "Shepparton VIC Australia"]
#
#    routes <<
#      ["Christchurch New Zealand",
#      "Rolleston New Zealand",
#      "Darfield New Zealand",
#      "Springfield New Zealand",
#      "Cass New Zealand",
#      "Arthurs Pass New Zealand",
#      "Otira New Zealand",
#      "Jacksons New Zealand",
#      "Moana New Zealand",
#      "Arnold Valley New Zealand",
#      "Dobson, West Coast, New Zealand",
#      "Greymouth New Zealand"]
#    routes <<
#      ["Picton New Zealand",
#      "Blenheim New Zealand",
#      "Seddon New Zealand",
#      "Kaikoura New Zealand",
#      "Mina New Zealand",
#      "Waipara New Zealand",
#      "Rangiora New Zealand",
#      "Christchurch New Zealand"]
#    routes <<
#      ["Auckland New Zealand",
#      "Middlemore New Zealand",
#      "Papakura New Zealand",
#      "Pukekohe New Zealand",
#      "Hamilton New Zealand",
#      "Otorohanga New Zealand",
#      "Te Kuiti New Zealand",
#      "Taumarunui New Zealand",
#      "National Park New Zealand",
#      "Ohakune New Zealand",
#      "Taihape New Zealand",
#      "Marton New Zealand",
#      "Feilding New Zealand",
#      "Palmerston North New Zealand",
#      "Levin New Zealand",
#      "Waikanae New Zealand",
#      "Paraparaumu New Zealand",
#      "Porirua New Zealand",
#      "Wellington New Zealand"]

#    #FERRY
#    routes <<
#      ["Wellington New Zealand",
#      "Picton New Zealand"
#      ]

    @geocoded_routes = []
    @used_stations = {}
#    routes.each do |route|
#      stored_route = Routes.create
#      route.each do |stop|
#        Stops.create(:routes_id => stored_route.id, :name => stop)
#      end
#    end
    Routes.all.each do |route|
      @geocoded_routes << get_stops_from_route(route)
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
    Stops.where(:routes_id => route.id).each do |stop|
      
      location = Location.where(:name => stop.name)
      if location.empty?
        geo = GoogleGeocoder.geocode(stop.name)
        
        Location.create(:name => stop.name, :lat => geo.lat, :lng => geo.lng)
        
        stops << [geo.lat, geo.lng]
        sleep 0.1

        @used_stations[stop] = true
      else
        if @used_stations[stop].nil?
          stops << [location.first.lat, location.first.lng, true]
          
          @used_stations[stop] = true
        else
          stops << [location.first.lat, location.first.lng, false]
        end
      end
    end

    stops
  end

#  def get_stops_from_route route
#    stops = []
#    route.each do |stop|
#
#      location = Location.where(:name => stop)
#      if location.empty?
#        geo = GoogleGeocoder.geocode(stop.to_s)
#
#        Location.create(:name => stop, :lat => geo.lat, :lng => geo.lng)
#
#        stops << [geo.lat, geo.lng]
#        sleep 0.1
#
#        @used_stations[stop] = true
#      else
#        if @used_stations[stop].nil?
#          stops << [location.first.lat, location.first.lng, true]
#
#          @used_stations[stop] = true
#        else
#          stops << [location.first.lat, location.first.lng, false]
#        end
#      end
#    end
#
#    stops
#  end

  def get_track_line_from_stops stops
    points = []
    stops.each do |stop|
      points << [stop.lat, stop.lng]
    end

    points
  end
end
