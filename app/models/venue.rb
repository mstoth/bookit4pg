class Venue < ActiveRecord::Base
  
  has_attached_file :vpic, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" },
  :storage => :s3,
  :bucket => 'bookit4pg',
  :s3_credentials => {
    :access_key_id => ENV['AKIAICR6FRQRFATSMPKQ'],
    :secret_access_key => ENV['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']
  },
  :path => "/:style/:id/:filename"
  
  geocoded_by :zip
  after_validation :geocode
end
