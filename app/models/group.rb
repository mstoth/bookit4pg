class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :concerts
  
  has_attached_file :picture, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" },
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :path => "/:style/:id/:filename"
  
  geocoded_by :zip
  after_validation :geocode
end
