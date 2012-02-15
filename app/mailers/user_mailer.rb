class UserMailer < ActionMailer::Base
  default from: "michael@virtualpianist.com"
  def welcome_venue(venue)
    @venue = venue
    @url  = "http://virtualbookingagent.com"
    mail(:to => venue.email, :subject => "Welcome to Virtual Booking Agent")
  end
  def welcome_group(group)
    @group = group
    @url = "http://virtualbookingagent.com"
    mail(:to=>group.email, :subject => "Your group has been added")
  end
  def welcome_user(user)
    @user = user
    @url = "http://virtualbookingagent.com"
    mail(:to=>user.email, :subject=> "Welcome to Virtual Booking Agent")
  end
  def new_concert(concert,venue)
    @concert = concert
    @venue = venue
    mail(:to=>v.email, :subject => "A new concert is being offered at Virtual Booking Agent.")
  end
end
