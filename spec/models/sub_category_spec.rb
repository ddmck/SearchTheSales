require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  subject(:sub_category) { build(:sub_category) }

  it 'should have a downcase name after saving' do
    name = sub_category.name

    sub_category.save

    expect(sub_category.name).to eq(name.downcase)
  end

  it 'should be able to find its products' do
    expect(sub_category).to respond_to(:products)
  end

  it 'should be able to save products on its self' do
    product = build(:product)
    sub_category.products << product
    expect(sub_category.products).to include(product)
  end

  it 'should have a parent category' do
    expect(sub_category.category).to_not be_nil
  end

end
