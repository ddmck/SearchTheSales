require 'rails_helper'

RSpec.describe Product, :type => :model do
  subject(:product) { create(:product) }
  let(:brand) { product.brand }
  let(:store) { product.store }
  let(:user) { build(:user) }

  it "should not be valid without a name" do
    product.name = nil
    expect(product).to_not be_valid
  end

  it "should not be valid without a brand_id" do
    product.brand_id = nil
    expect(product).to_not be_valid
  end

  it "should not be valid without a store_id" do
    product.store_id = nil
    expect(product).to_not be_valid
  end

  it "should not be valid without a url" do
    product.url = nil
    expect(product).to_not be_valid
  end

  it "should return its brand" do
    expect(product.brand).to eq(brand)
  end

  it "should return its store" do
    expect(product.store).to eq(store)
  end

  it "should know who has wished for it" do
    expect(product.wished_for_by).to be_empty
  end

  it "should be able to return its colors" do
    expect(product).to respond_to(:colors)
  end

  it "should have a factory" do 
    prod = create(:product)
  end

end
