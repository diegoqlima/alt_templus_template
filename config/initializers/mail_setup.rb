catcher = {
  :address => "localhost",
  :port => 1025 
}

# prod =  {
#   :address => 'localhost',
#   :domain => 'novomundo.com.br',
#   :port => 25,
#   :openssl_verify_mode => 'none'
# }

stage =  {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "rarolabs.com.br",
  :user_name            => "naoresponda@rarolabs.com.br",
  :password             => "labsrarolabs",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

if Rails.env == "production"
  server = ActionMailer::Base.smtp_settings = stage
elsif Rails.env == "stage"
  server = ActionMailer::Base.smtp_settings = stage
else
  server = ActionMailer::Base.smtp_settings = catcher
end

Mail.defaults do
  delivery_method :smtp, server
end