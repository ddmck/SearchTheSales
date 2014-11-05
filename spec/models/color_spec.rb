require 'rails_helper'

RSpec.describe Color, :type => :model do
  subject(:color) {Color.new(name: "Black")}

  it "should be downcase after saving" do
    name = "Red"
    color.name = name
    color.save
    expect(color.name).to eq(name.downcase)
  end

  it "should respond to products" do
    expect(color).to respond_to(:products)
  end

  it "should have a unique name" do
    color.save
    color2 = Color.create(name: "Black")
    expect(color2).to_not be_valid
  end
end
