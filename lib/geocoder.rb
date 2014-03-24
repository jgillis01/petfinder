# This is an attempt to call the geocoder api
# http://geocoder.us

require 'httparty'
class GeoCoder
  HOST = 'http://geocoder.us/service/csv/geocode'

  # result format "lat, lng, city, state, zipcode"
  def geoencode(zipcode)
    uri = HOST + "?zip=#{zipcode}"
    lat,lng,city,state,zipcode = HTTParty.get(uri).body.split(',')
    {
      :lat => lat.to_f,
      :lng => lng.to_f,
      :city => city.strip,
      :state => state.strip,
      :zipcode => zipcode.strip
    }
  end

end
