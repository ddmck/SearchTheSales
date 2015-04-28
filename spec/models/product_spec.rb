require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { build(:product) }
  let(:brand) { product.brand }
  let(:store) { product.store }
  let(:user) { build(:user) }

  before(:example) do
    cats = ["accessories","bags","blouses",
            "shoes","dresses","hoodies",
            "jackets","jeans","knitwear",
            "polos","shirts","shorts",
            "skirts","suits","sweats",
            "swimwear","tees","tops",
            "trousers","underwear","lingerie",
            "playsuits"]

    sub_shoes = ["trainers","heels","loafers",
                 "espadrilles","wedges","flops",
                 "sneakers","brogues","platforms",
                 "plimsolls","slipons","boots"]

    cats.each do |c|
      create(:category, name: c)
    end

    sub_shoes.each do |c|
      create(:sub_category, name: c, category: )
    end
  end

  it 'should not be valid without a name' do
    product.name = nil
    expect(product).to_not be_valid
  end

  # it 'should be valid without a brand_id' do
  #   product.brand_id = nil
  #   expect(product).to be_valid
  # end

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

  it 'should be able to find its category' do
    expect(product).to respond_to(:category)
  end

  it 'should be able to calculate a category' do
    product = build(:product, :shoes)
    
    match_array = []
    match_array << product.name
    cat = product.calc_category(match_array)
    expect(cat.name).to eq("shoes")
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

  it "should be able to build a where hash for itself" do
    filters = {
      "category" => 1,
      "brand" => 1
    }
    result = product.build_where_hash(filters)
    desired = {
      category_id: 1,
      brand_id: 1
    }
    expect(result).to eq(desired)
  end

end
