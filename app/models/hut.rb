class Hut < ActiveRecord::Base
  has_one :point
  validates_presence_of :name
  
  # scope :near, lambda{ |*args|
  #                       origin = *args.first[:origin]
  #                       if (origin).is_a?(Array)
  #                         origin_lat, origin_lng = origin
  #                       else
  #                         origin_lat, origin_lng = origin.latitude, origin.longitude
  #                       end
  #                       origin_lat, origin_lng = (origin_lat * Math::PI / 180), (origin_lng * Math::PI / 180)
  #                       within = *args.first[:within]
  #                       {
  #                         :conditions => %(
  #                           (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(huts.lat))*COS(RADIANS(huts.lng))+
  #                           COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(huts.lat))*SIN(RADIANS(huts.lng))+
  #                           SIN(#{origin_lat})*SIN(RADIANS(huts.lat)))*3963) <= #{within}
  #                         ),
  #                         :select => %( huts.*,
  #                           (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(huts.lat))*COS(RADIANS(huts.lng))+
  #                           COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(huts.lat))*SIN(RADIANS(huts.lng))+
  #                           SIN(#{origin_lat})*SIN(RADIANS(huts.lat)))*3963) AS distance
  #                         )
  #                       }
  #                     }
                      
end
