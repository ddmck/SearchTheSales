class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :text
  validates_presence_of :sender_id
  after_create :update_ui

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
      send_webhook
    end
  end

  def send_webhook
    HTTParty.post(ENV["SOCKET_URL"] + "/news", {query: {text: self.text, senderID: self.sender_id, toUser: self.user_id}})
  end
end
