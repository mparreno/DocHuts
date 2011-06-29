class Point < ActiveRecord::Base
  belongs_to :hut

  validates_numericality_of :latitude, :less_than => 181, :more_than => -181
  validates_numericality_of :longitude, :less_than => 181, :more_than => -181
  
  
end
