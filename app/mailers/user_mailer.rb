class UserMailer < ActionMailer::Base
  default from: "michael@virtualpianist.com"
  def welcome_email(user)
    @user = user
    @url  = "http://virtualbookingagent.com"
    mail(:to => user.email, :subject => "Welcome to Virtual Booking Agent")
  end
end
