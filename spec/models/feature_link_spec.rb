require 'rails_helper'

RSpec.describe FeatureLink, :type => :model do
  subject(:feature_link) {build(:feature_link) }

  it "should have all the nessecary fields" do
    feature_link.name = nil
    expect(feature_link).to_not be_valid

    feature_link = build(:feature_link)
    feature_link.link_url = nil
    expect(feature_link).to_not be_valid

    feature_link = build(:feature_link)
    feature_link.feature_id = nil
    expect(feature_link).to_not be_valid
  end
end
