require 'rails_helper'
require 'nokogiri'

RSpec.describe 'data_feed_xml', :type => :model do
  subject(:data_feed_xml) { build(:data_feed_xml) }
  let(:store) { build(:store) }

  it "should not be valid without a File" do
    data_feed_xml.file = nil
    expect(data_feed_xml).to_not be_valid
  end

  it "should have a store" do
    expect(data_feed_xml).to respond_to(:store)
  end

  it "should set an XML file to doc" do
    doc = Nokogiri::XML(open(Rails.root + 'spec/support/test.xml'))
    obj = double(data_feed_xml.get_doc)
    expect(obj).should_return(Nokogiri::XML(File.open("")))
  end
end