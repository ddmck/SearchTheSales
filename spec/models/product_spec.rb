require 'rails_helper'

RSpec.describe Product, type: :model do
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

  it 'should be able to find its sub_category' do
    expect(product).to respond_to(:sub_category)
  end

  it 'should accept a sub category' do
    sub_category = build(:sub_category)
    product.sub_category = sub_category
    expect(product.sub_category).to eq(sub_category)
  end

  it 'should respond to trends' do
    expect(product).to respond_to(:trends)
  end

  it 'should accept trends' do
    trend = build(:trend)
    product.trends << trend
    expect(product.trends).to include(trend)
  end

  it "should respond to gender" do
    expect(product).to respond_to(:gender)
  end

end
