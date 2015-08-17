require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }
  
  it 'should be able to find its first name' do
    user.name = "Donald McKendrick"
    expect(user.first_name).to eq("Donald")
  end

  it 'should be able to set gender on itself' do
    user.name = "Donald McKendrick"
    expect(user.gender).to eq("male")
    
    user.name = "Donald"
    expect(user.gender).to eq("male")
  
    user.name = "Donna"
    expect(user.gender).to eq("female")
    
    user.name = ""
    expect(user.gender).to eq("andy")
   
    user.name = "lindsey"
    expect(user.gender).to eq("andy")
    
    user.name = "stevie"
    expect(user.gender).to eq("andy")
  end
end
