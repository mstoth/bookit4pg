class Venue < ActiveRecord::Base
  has_attached_file :vpic, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" }
  geocoded_by :zip
  after_validation :geocode
end
