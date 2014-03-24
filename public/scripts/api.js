(function() {
  var GeoCoder, GoogleMap, map;
  map = null;
  window.GeoCoder = GeoCoder = (function() {
    function GeoCoder(zipcode) {
      this.zipcode = zipcode;
    }
    GeoCoder.prototype.getCoordinates = function(callback) {
      return $.get('api/geocoder/' + this.zipcode, callback, 'json');
    };
    return GeoCoder;
  })();
  window.GoogleMap = GoogleMap = (function() {
    function GoogleMap(canvas_id) {
      this.canvas_id = canvas_id;
      this.map = null;
    }
    GoogleMap.prototype.renderMap = function(data) {
      var latLng, options, request, service;
      latLng = new google.maps.LatLng(data.geocoder.lat, data.geocoder.lng);
      options = {
        zoom: 15,
        center: latLng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      request = {
        location: latLng,
        radius: 2500,
        types: ['veterinary_care', 'pet_store']
      };
      console.log(data.geocoder);
      map = new google.maps.Map(document.getElementById(this.canvas_id), options);
      console.log(map);
      service = new google.maps.places.PlacesService(map);
      service.search(request, this.placeMarker);
      return map;
    };
    GoogleMap.prototype.placeMarker = function(results, status) {
      var marker, placeLoc, result, _i, _len, _results;
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        _results = [];
        for (_i = 0, _len = results.length; _i < _len; _i++) {
          result = results[_i];
          placeLoc = result.geometry.location;
          marker = new google.maps.Marker({
            map: map,
            position: new google.maps.LatLng(placeLoc.lat(), placeLoc.lng())
          });
          _results.push(google.maps.event.addListener(marker, 'click', function() {
            var infoWindow;
            infoWindow = new google.maps.InfoWindow();
            infoWindow.setContent(result.name);
            return infoWindow.open(map, this);
          }));
        }
        return _results;
      }
    };
    return GoogleMap;
  })();
}).call(this);
