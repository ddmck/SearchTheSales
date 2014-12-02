require 'rails_helper'

RSpec.describe Store, :type => :model do
  subject(:store) { build(:store) }

  it "should not be valid without a name" do
    store.name = nil
    expect(store).to_not be_valid
  end

  it "should know its datafeed" do
    expect(store).to respond_to(:data_feed)
  end

  it "should know its products" do
    expect(store).to respond_to(:products)
  end
end
