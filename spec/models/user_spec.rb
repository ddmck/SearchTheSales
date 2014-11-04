require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) { User.new(username: "donaldmckendrick",
                           email: "ddmckendrick@gmail.com",
                           password: "password", 
                           password_confirmation: "password")}

  it "should have an empty wishlist at the start" do
    expect(user.wishlist).to be_empty
  end

  it "should have a basket at the start" do
    user.save
    puts "Basket: #{user.basket}"
    expect(user.basket.products).to be_empty
  end

end
