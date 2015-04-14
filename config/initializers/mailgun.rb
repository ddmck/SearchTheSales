# # Initialize your Mailgun object:
# Mailgun.configure do |config|
#   config.api_key = ENV['MAILGUN_API_KEY']
#   config.domain  = 'https://api.mailgun.net/v2/mg.fetchmyfashion.com'
# end

# @mailgun = Mailgun()

require 'mailgunner'

mailgun = Mailgunner::Client.new({
  domain: 'mg.fetchmyfashion.com',
  api_key: 'key-bf23e915918b0d67d1f91316b1dec26a'
})

# response = mailgun.get_stats(limit: 5)