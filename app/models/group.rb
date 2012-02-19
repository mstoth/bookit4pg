class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :concerts
  
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :storage => :s3,
  :url  => '/pictures/:style/:basename.:extension',
  :path => 'pictures/:style/:basename.:extension',
  :bucket => 'bookit4pg',
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
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
  
  validates_presence_of  :phone, :zip, :title, :email, :website, :contact
  
end
