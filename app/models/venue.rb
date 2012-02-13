class Venue < ActiveRecord::Base
  
  has_attached_file :vpic, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" },
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :url  => '/vpic/:style/:basename.:extension',
  :path => 'vpic/:style/:basename.:extension',
  :bucket => 'bookit4pg',
  :storage => :s3,
  :path => "/:style/:id/:filename"
  
  geocoded_by :zip
  after_validation :geocode
end
