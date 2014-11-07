require 'rails_helper'

RSpec.describe Color, :type => :model do
  subject(:color) { build(:color) }

  it 'should be downcase after saving' do
    name = color.name
    color.save
    expect(color.name).to eq(name.downcase)
  end

  it 'should respond to products' do
    expect(color).to respond_to(:products)
  end

  it 'should accept products' do
    product = build(:product)
    color.products << product
    expect(color.products).to include(product)
  end


end
