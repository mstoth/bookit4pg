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
  
  validates_format_of :phone,
  :message => "must be a valid telephone number.",
  :with => /^[\(\)0-9\- \+\.]{10,20}$/
  
  validates_format_of :zip,
  :message => "only the 5-digit zip code is needed1",
  :with => /^[0-9]{5}$/

  validates_format_of :website, :with =>
  /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  validates_presence_of  :phone, :zip, :name, :email, :website, :contact
end
