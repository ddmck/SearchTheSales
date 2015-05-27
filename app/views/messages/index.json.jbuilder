json.array!(@messages) do |message|
  json.extract! message, :id, :text, :sender_id, :user_id, :seen
  json.created_at message.created_at.to_formatted_s(:number)
  json.sender_name message.sender_name 
end
