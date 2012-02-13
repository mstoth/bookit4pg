class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :concerts
  
  has_attached_file :picture, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" },
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
