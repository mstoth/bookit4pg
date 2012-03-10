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
  
  def new_concert(concert,user)
    @concert = concert
    @user = user
    @url = "http://virtualbookingagent.com"
    @stop_notify = "http://virtualbookingagent.com/users/stop_notification?id=#{@user.id}"
    mail(:to=>user.email, :subject => "A new concert is being offered at Virtual Booking Agent.")
  end
  
  def newgroup(group,user)
    @group=group
    @user=user
    @stop_notify = "http://virtualbookingagent.com/users/stop_notification?id=#{@user.id}"
    @url = "http://virtualbookingagent.com"
    mail(:to=>@user.email, :subject=>'New group added to Virtual Booking Agent')
  end
  
  def send_password(user,new_password) 
    @user = user
    @new_password=new_password
    mail(:to=>@user.email, :subject=>'password reset')
  end
  
  def password_reset_instructions(user)  
    @user = user
    @url = "http://virtualbookingagent.com/password_resets/#{user.perishable_token}/edit"
    mail(:to=>@user.email, :subject=>'Password Reset Instructions')
  end
end
