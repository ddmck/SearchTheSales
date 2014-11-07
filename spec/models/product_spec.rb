require 'rails_helper'

RSpec.describe Product, :type => :model do
  subject(:product) { build(:product) }
  let(:brand) { product.brand }
  let(:store) { product.store }
  let(:user) { build(:user) }

  it 'should not be valid without a name' do
    product.name = nil
    expect(product).to_not be_valid
  end

  it 'should not be valid without a brand_id' do
    product.brand_id = nil
    expect(product).to_not be_valid
  end

  it 'should not be valid without a store_id' do
    product.store_id = nil
    expect(product).to_not be_valid
  end

  it 'should not be valid without a url' do
    product.url = nil
    expect(product).to_not be_valid
  end

  it 'should return its brand' do
    expect(product.brand).to eq(brand)
  end

  it 'should return its store' do
    expect(product.store).to eq(store)
  end

  it 'should know who has wished for it' do
    expect(product.wished_for_by).to be_empty
  end

  it 'should be able to return its colors' do
    expect(product).to respond_to(:colors)
  end

  it 'should accept a color' do
    color = build(:color)
    product.colors << color
    expect(product.colors).to include(color)
  end

  it 'should accept many colors' do 
    color = build(:color)
    product.colors << color
    expect(product.colors).to include(color)
    
    color2 = build(:color, name: 'Black')
    product.colors << color2
    expect(product.colors).to include(color2)
  end

  it 'should be able to find its sub_categories' do
    expect(product).to respond_to(:sub_categories)
  end

  it 'should accept sub categories' do
    sub_category = build(:sub_category)
    product.sub_categories << sub_category
    expect(product.sub_categories).to include(sub_category)
  end

  it 'should accept many sub_categories' do
    sub_category = build(:sub_category)
    product.sub_categories << sub_category
    expect(product.sub_categories).to include(sub_category)

    sub_category2 = build(:sub_category)
    product.sub_categories << sub_category2
    expect(product.sub_categories).to include(sub_category, sub_category2)
  end

end
