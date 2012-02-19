class Concert < ActiveRecord::Base
  geocoded_by :zip
  after_validation :geocode
  validates_presence_of :zip, :webpage, :title, :genre
  validates_format_of :webpage,
  :message => "must be a valid URL",
  :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates_format_of :zip,
  :message => "only the 5-digit zip code is needed",
  :with => /^[0-9]{5}$/

end
