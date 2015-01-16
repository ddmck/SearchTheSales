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
    expect(data_feed.sanitize_string(142867).class).to eq(String)
    expect(data_feed.sanitize_string(0.0).class).to eq(String)
    expect(data_feed.sanitize_string(10000000.00).class).to eq(String)
    expect(data_feed.sanitize_string([1,2,3]).class).to eq(String)
    expect(data_feed.sanitize_string({hash: "hash"}).class).to eq(String)
  end

  it "should be able to clean up prices" do
    expect(data_feed.sanitize_price("£12.34")).to eq(12.34)
    expect(data_feed.sanitize_price("GBP12.34")).to eq(12.34)
    expect(data_feed.sanitize_price("£1,234.56")).to eq(1234.56)
    expect(data_feed.sanitize_price("£12")).to eq(12.00)
    expect(data_feed.sanitize_price("£1 234.56")).to eq(1234.56)
    expect(data_feed.sanitize_price(12)).to eq(12.00)
    expect(data_feed.sanitize_price(134.99)).to eq(134.99)
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

  it "should be able to sanitize sizes" do
    # "10 (S)|12 (M)|14 (L)|16 (XL)|8 (XS)", "10 (38)|12 (40)|14 (42)", "XL", "one size", "L,M,L", "XXL (6)|XXXL (7)", "SMALL (36/38\"\" Chest)|MEDIUM (38/40\"\" Chest)|LARGE (40/42\"\" Chest)|XL (42/44\"\" Chest)|3XL (46/48\"\" Chest)", "XL (5)|XXL (6)|XXXL (7)", "Medium (36/38\"\" Chest)|XL (40/42\"\" Chest)|XXL (42/44\"\" Chest)", "10 (S)|14 (L)|16 (XL)", "Medium (36/38\"\" Chest)|Large (38/40\"\" Chest)|XL (40/42\"\" Chest)|XXL (42/44\"\" Chest)", "XXL (6)"
    expect(data_feed.sanitize_sizes("")).to eq([])
    expect(data_feed.sanitize_sizes("UK One Size")).to eq(["UK ONE SIZE"])
    expect(data_feed.sanitize_sizes("Extra Sml|Medium|Small")).to eq(["EXTRA SML", "MEDIUM", "SMALL"])
    expect(data_feed.sanitize_sizes("1|3")).to eq(["1", "3"])
    expect(data_feed.sanitize_sizes("10|12|14|8")).to eq(["10", "12", "14", "8"])
    expect(data_feed.sanitize_sizes("Extra Small|Large|Medium|Small")).to eq(["EXTRA SMALL", "LARGE", "MEDIUM", "SMALL"])
    expect(data_feed.sanitize_sizes("Small (36/38\"\" Chest)|Medium (38/40\"\" Chest)|XS (34/36\"\" Chest)")).to eq(["SMALL (36/38\"\" CHEST)","MEDIUM (38/40\"\" CHEST)","XS (34/36\"\" CHEST)"])
    expect(data_feed.sanitize_sizes("Extra Sml |Medium |Small ")).to eq(["EXTRA SML", "MEDIUM", "SMALL"])
    expect(data_feed.sanitize_sizes(" Extra Sml | Medium | Small ")).to eq(["EXTRA SML", "MEDIUM", "SMALL"])
  end
end
