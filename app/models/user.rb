class User < ActiveRecord::Base
  has_many :venues
  has_and_belongs_to_many :groups
  acts_as_authentic
  geocoded_by :zip
  after_validation :geocode
  validates_presence_of :zip
  validates_uniqueness_of :login
  validates_presence_of :login
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver
  end

  def join_group
    id=params[:id]
    g=Group.find(id)
    self.groups << g
  end
  
  def my_concerts
    groups=self.groups
    @concerts = []
    groups.each do |g|
      g.concerts.each do |c|
        @concerts << c
      end
    end
    @concerts
  end
end
