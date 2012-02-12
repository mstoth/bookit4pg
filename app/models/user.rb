class User < ActiveRecord::Base
  has_many :venues
  has_many :groups
  acts_as_authentic
end
