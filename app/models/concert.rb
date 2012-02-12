class Concert < ActiveRecord::Base
  geocoded_by :zip
  after_validation :geocode
end
