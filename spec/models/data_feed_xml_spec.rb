require 'rails_helper'

RSpec.describe DataFeed, :type => :model do
  subject(:data_feed_xml) { build(:data_feed_xml) }
  let(:store) { build(:store) }

  it "should not be valid without a File" do
    data_feed_xml.file = nil
    expect(data_feed_xml).to_not be_valid
  end
end