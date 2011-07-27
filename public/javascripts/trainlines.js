function png(lat, lng, title)
{
  markers.push(new google.maps.Marker({position: p(lat, lng), title: title}));
  counter++;
}

function dl(points, map)
{
  var line = new google.maps.Polyline({
    path: points,
    strokeColor: "#FF0000",
    strokeOpacity: 1.0,
    strokeWeight: 2
  });

  line.setMap(map);
}

function p(lat,lng)
{
  return new google.maps.LatLng(lat, lng)
}

function create_marker_cluster()
{
  if (counter == done)
  {
    clearInterval ( created );
    mc = new MarkerClusterer(map, markers);
  }
}