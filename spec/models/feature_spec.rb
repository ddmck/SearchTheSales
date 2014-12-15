require 'rails_helper'

RSpec.describe Feature, :type => :model do
  subject(:feature) {build(:feature)}

  it "should not be valid with out a title" do
    feature.title = nil
    expect(feature).to_not be_valid
  end

  it "should not be valid with out a copy" do
    feature.copy = nil
    expect(feature).to_not be_valid
  end

  it "should be able to prepare its products where hash" do
    desired_hash = {
      brand_id: feature.brand.id,
      store_id: feature.store.id,
      category_id: feature.category.id,
      sub_category_id: feature.sub_category.id,
      gender_id: feature.gender.id,
    }
    expect(feature.build_where_statement).to eq(desired_hash.stringify_keys)
  end

  it "should only pass to hash if value exists" do
    feature.brand = nil
    expect(feature.brand).to be_nil

    desired_hash = {
      store_id: feature.store.id,
      category_id: feature.category.id,
      sub_category_id: feature.sub_category.id,
      gender_id: feature.gender.id,
    }    

    expect(feature.build_where_statement).to eq(desired_hash.stringify_keys)
  end

  it "should be able to prepare its search string" do
    desired_string = "~ AND brand_id: #{feature.brand_id} AND category_id: #{feature.category_id} AND sub_category_id: #{feature.sub_category_id} AND gender_id: #{feature.gender_id} AND store_id: #{feature.store_id}"
    expect(feature.build_search_string).to include(desired_string)
  end
end
