ActionMailer::Base.smtp_settings = {
   :address              => "smtpout.secureserver.net",
   :port                 => 80,
   :domain               => "virtualpianist.com",
   :user_name            => "michael@virtualpianist.com",
   :password             => "ArchDukeTr1o",
   :authentication       => "plain",
   :enable_starttls_auto => true
}
