require 'rails_helper'

RSpec.describe Gender, type: :model do
  subject(:gender) {build(:gender)}

  it "should respond to products" do
    expect(gender).to respond_to(:products)
  end
end
