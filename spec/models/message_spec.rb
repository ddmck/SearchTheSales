require 'rails_helper'

RSpec.describe Message, type: :model do
  subject(:message) { build(:message)}

  it 'should not be valid without a message' do
    message.text = nil
    expect(message).to_not be_valid
  end

  it 'should not be valid without a sender id' do
    message.sender_id = nil
    expect(message).to_not be_valid
  end

  it 'should be able to generate its sender name' do
    sender = User.find(message.sender_id)
    expect(message.sender_name).to eq(sender.name)
  end 
end
