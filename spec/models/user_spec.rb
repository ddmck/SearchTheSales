require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) { create(:user)}

  it "should have a unique username" do
    user1 = create(:user)
    expect(build(:user, username: user1.username)).to_not be_valid
  end

  it "should have an empty wishlist at the start" do
    expect(user.wishlist).to be_empty
  end

  it "should have a basket at the start" do
    user.save
    expect(user).to respond_to(:basket)
  end

end
