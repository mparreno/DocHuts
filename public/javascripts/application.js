var map;
var markers = [];

window.onresize = trigger_resize;

function initializeIndex()
{
	set_map_height_to($(document).height());
	
	drawMap(166.1005859, -47.519741, 179.9653320, -34.0011456, google.maps.MapTypeId.TERRAIN, 5);
	loadAllHuts();
	
	var mcOptions     = { gridSize: 80, maxZoom: 12 }
	var markerCluster = new MarkerClusterer(map, markers, mcOptions)
}

//sets the correct height of the map
//this should be called onload and onresize
function set_map_height_to(viewportheight) {
	
    var mainHeight = viewportheight - 62
    var mapHeight = mainHeight

		$('#content').height(mainHeight);
    if ($('#map_div')) {
        $('#map_div').height(mapHeight);
    }
}

function trigger_resize() {
	set_map_height_to($(document).height());
	google.maps.event.trigger(map, 'resize');
} 


function drawMap(minLng, minLat, maxLng, maxLat, mapType, zoomLevel) {
    // NZ bounding box
    var sw = new google.maps.LatLng(minLat, minLng)
    var ne = new google.maps.LatLng(maxLat, maxLng)

    // Create a bounding box  
    var bounds = new google.maps.LatLngBounds(sw, ne)

    var myOptions = {
        zoom: zoomLevel,
        center: bounds.getCenter(),
        mapTypeId: mapType,
        scrollwheel: false,
        streetViewControl: false,
        scaleControl: true,
        overviewMapControl: true
    }
    

    map = new google.maps.Map(document.getElementById("map_div"), myOptions)
    
}

function getInfoWindowTextForTrack(name, id) {
    var text = '<div class="hut_info">' + 
               '<h4>' + name + '</h4>' +
               '<p><a href="/huts/' + id + '">View more information</a></p>' +
               '</div>'  
    return text
}

function addHutMarker(name, latlng, id) {
    var infowindow = new google.maps.InfoWindow({ content: getInfoWindowTextForTrack(name, id) });
    var marker = new google.maps.Marker({ position: latlng, map: map, title: name, icon: '../images/home.png' });
    markers.push(marker);
    google.maps.event.addListener(marker, 'click', function() { infowindow.open(map, marker); });
}

function loadAllHuts() {
	  
    $.ajax({
		      beforeSend      : function(request) { request.setRequestHeader("Accept", "text/javascript"); },
		      type            : 'GET',
		      url             : '/huts',
					success					: function() { loadHuts(); 
																					var mcOptions     = { gridSize: 50, maxZoom: 12 };
																					var markerCluster = new MarkerClusterer(map, markers, mcOptions);
																				}
		});

}


function initializeShow(name, point, id)
{
	var text = '<div class="hut_info">' + 
             '<h4>' + name + '</h4>' +
             '</div>';

	set_map_height_to($(document).height());
	drawMap(166.1005859, -47.519741, 179.9653320, -34.0011456, google.maps.MapTypeId.TERRAIN, 20);
	var infowindow = new google.maps.InfoWindow({ content: text });
  var marker = new google.maps.Marker({ position: point, map: map, title: name, icon: '../images/home.png' });
  markers.push(marker);
  infowindow.open(map, marker);
  google.maps.event.addListener(marker, 'click', function() { infowindow.open(map, marker); });

	map.setCenter(point);
	map.setZoom(10);
}