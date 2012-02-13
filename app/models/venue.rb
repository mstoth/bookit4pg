class Venue < ActiveRecord::Base
  
  has_attached_file :vpic, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" },
  :storage => :s3,
  :s3_credentials => S3_CREDENTIALS,
  :path => "/:style/:id/:filename"
  
  geocoded_by :zip
  after_validation :geocode
end
