# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bookit4pg::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :address  => "smtpout.secureserver.net",
  :port  => 25,
  :user_name  => "michael@virtualpianist.com",
  :password  => "iiip13",
  :authentication  => :login
}
