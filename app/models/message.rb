require 'yo4r'
class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :text
  validates_presence_of :sender_id
  after_create :update_ui
  after_create :yo_team

  def sender_name
    sender.name
  end

  def sender
  	if user_id == sender_id
    	User.find(sender_id)
    else
    	Admin.find(sender_id)
    end
  end

  def update_ui
    if sender_id != user_id
      send_user_webhook
      if user.push_token?
        user.send_push_notification("New message from your stylist!")
      end
    else
      send_admin_webhook
    end

  end

  def send_user_webhook
    HTTParty.post(ENV["SOCKET_URL"] + "/news", {query: {text: self.text, senderID: self.sender_id, toUser: self.user_id}})
  end

  def send_admin_webhook
    HTTParty.post(ENV["SOCKET_URL"] + "/admin_news", {query: {text: self.text, senderID: self.sender_id, toUser: self.user_id}})
  end

  def yo_team
    if sender_id == user_id
      client = Yo::Client.new(api_token: 'cfb6c7c9-b95c-4253-be12-9a3fce605510')
      client.yo(username: "bertiewilson")
    end
  end
end
