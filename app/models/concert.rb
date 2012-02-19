class Concert < ActiveRecord::Base
  geocoded_by :zip
  after_validation :geocode
  validates_presence_of :zip, :webpage, :title, :genre
  validates_format_of :webpage,
  :message => "must be a valid URL",
  :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

end
