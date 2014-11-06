require 'rails_helper'

RSpec.describe Category, :type => :model do
  subject(:category) { build(:category) }

  it "should downcase its name after saving" do
    name = category.name
    category.save
    expect(category.name).to eq(name.downcase)
  end

  it "should have a unique name" do
    category.save
    category2 = build(:category)
    expect(category2).to_not be_valid
  end

  it "should be able to find its sub categories" do
    expect(category).to respond_to(:sub_categories)
  end
end
