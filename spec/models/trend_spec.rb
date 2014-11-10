require 'rails_helper'

RSpec.describe Trend, type: :model do
  subject(:trend) { build(:trend) }

  it 'should respond to products' do
    expect(trend).to respond_to(:products)
  end

  it 'should receive products' do
    product = build(:product)
    trend.products << product
    expect(trend.products).to include(product)
  end
end
