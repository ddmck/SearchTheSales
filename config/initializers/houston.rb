if Rails.env == "development"
  APN = Houston::Client.development
  APN.certificate = File.read("apple_push_notification_dev.pem")
else
  APN = Houston::Client.production
  APN.certificate = File.read("apple_push_notification.pem")
end
