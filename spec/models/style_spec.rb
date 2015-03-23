require 'rails_helper'

RSpec.describe Style, :type => :model do
  subject(:style) { build(:style) }

  it "should it should know if it contains a space" do
    expect(style.contains_space?).to eq(false)
    style.name = "waist coat"
    expect(style.contains_space?).to eq(true)
  end

  it "should be able to generate - seperated styles" do
    style.name = "waist coat"
    expect(style.pseudonyms).to eq(["waist coat","waist-coat","waistcoat"])
  end
end
