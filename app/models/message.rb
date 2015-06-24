class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :text
  validates_presence_of :sender_id

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
end
