require 'rails_helper'

RSpec.describe Product, :type => :model do
  let(:brand) { Brand.create(name: "Levi", 
                             feature_text: "So cool I wear them every day",
                             image_url: "www.image.com" )}

  let(:store) { Store.create(name: "House of Fraser", 
                             url: "www.hof.com",
                             image_url: "www.img.com")}

  subject(:product) { Product.new(name: "Jeans", 
                                  brand_id: brand.id, 
                                  store_id: store.id, 
                                  url: "www.levi.com", 
                                  image_url: "www.image.com", 
                                  description: "Really nice!", 
                                  gender: "male") }

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
end
