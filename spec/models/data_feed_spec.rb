require 'rails_helper'

RSpec.describe DataFeed, :type => :model do
  subject(:data_feed) { build(:data_feed) }
  let(:store) { build(:store) }

  it "should not be valid without a datafeed URL" do
    data_feed.feed_url = nil
    expect(data_feed).to_not be_valid
  end

  it "should have a store" do
    expect(data_feed).to respond_to(:store)
  end

  it "should be able to clean up strings" do
    expect(data_feed.sanitize_string("slip-on")).to eq("slipon")
    expect(data_feed.sanitize_string("slip-on jeans")).to eq("slipon jeans")
    expect(data_feed.sanitize_string("jean's")).to eq("jeans")
  end

  it "should be able to clean up prices" do
    expect(data_feed.sanitize_price("£12.34")).to eq(12.34)
    expect(data_feed.sanitize_price("GBP12.34")).to eq(12.34)
    expect(data_feed.sanitize_price("£1,234.56")).to eq(1234.56)
    expect(data_feed.sanitize_price("£12")).to eq(12.00)
    expect(data_feed.sanitize_price("£1 234.56")).to eq(1234.56)
    expect(data_feed.sanitize_price(12)).to eq(12.00)
  end

  it "should be able to detect gender" do
    expect(data_feed.detect_gender("mens fleece black")).to eq("male")
    expect(data_feed.detect_gender("men's fleece black")).to eq("male")
    expect(data_feed.detect_gender("womens fleece black")).to eq("female")
    expect(data_feed.detect_gender("women's fleece black")).to eq("female")
    expect(data_feed.detect_gender("ladies fleece black")).to eq("female")
    expect(data_feed.detect_gender("girls fleece black")).to eq("female")
    expect(data_feed.detect_gender("girl's fleece black")).to eq("female")
    expect(data_feed.detect_gender("boys fleece black")).to eq("male")
    expect(data_feed.detect_gender("boy's fleece black")).to eq("male")
    expect(data_feed.detect_gender("male fleece black")).to eq("male")
    expect(data_feed.detect_gender("males fleece black")).to eq("male")
    expect(data_feed.detect_gender("female fleece black")).to eq("female")
    expect(data_feed.detect_gender("females fleece black")).to eq("female")
    expect(data_feed.detect_gender("unisex fleece black")).to eq("unisex")
    expect(data_feed.detect_gender("uni-sex fleece black")).to eq("unisex")
    expect(data_feed.detect_gender("men's fleece plain, black")).to eq("male")
    expect(data_feed.detect_gender("Women > Dresses")).to eq("female")
    expect(data_feed.detect_gender("Men > Tops & T-Shirts > Men's T-Shirts")).to eq("male")
    expect(data_feed.detect_gender("Men > Tops & T-Shirts")).to eq("male")
  end
end
