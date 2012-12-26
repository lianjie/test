class Point < ActiveRecord::Base
  attr_accessible :lat, :lon
  
  def convert
    point_plat = Pointplat.new
    lat = Math.log(Math.tan((self.lat+90)*Math::PI/360))/(Math::PI/180)*20037508.342789/180
    lon = self.lon * 20037508.342789 / 180
    point_plat.lat = lat
    point_plat.lon = lon
    point_plat
  end
  
  
end 

class Pointplat
  attr_accessor :lat, :lon
  def recover
    point = Point.new
    lat = self.lat/20037508.34*180
    lat = 180/Math::PI*(2*Math.atan(Math.exp(lat*Math::PI/180))-Math::PI/2)
    lon = self.lon/20037508.34*180
    point.lat = lat
    point.lon = lon
    point
  end
end
