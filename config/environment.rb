# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bookit4pg::Application.initialize!


# ActionMailer::Base.smtp_settings = {
#   :address  => "smtpout.secureserver.net",
#   :port  => 25,
#  :user_name  => "michael@virtualpianist.com",
#  :password  => "ArchDukeTr1o",
#  :authentication  => :login
#}

ActionMailer::Base.smtp_settings = {
   :address              => "smtpout.secureserver.net",
   :port                 => 80,
   :domain               => "virtualpianist.com",
   :user_name            => "michael@virtualpianist.com",
   :password             => "ArchDukeTr1o",
   :authentication       => "plain",
   :enable_starttls_auto => true
}
