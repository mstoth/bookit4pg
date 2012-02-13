if Rails.env == "production" 
   S3_CREDENTIALS = { :access_key_id => ENV['AKIAICR6FRQRFATSMPKQ'], :secret_access_key => ENV['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'], :bucket => "bookit4pg"} 
 else 
   S3_CREDENTIALS = Rails.root.join("config/s3.yml")
end
