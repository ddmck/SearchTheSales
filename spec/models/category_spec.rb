require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) { build(:category) }

  it 'should have traits that work' do
    category = build(:category, :hoodies)
    expect(category.name).to eq("hoodies")
  end

  it 'should have categories that have female_only' do
    category = build(:category, :playsuits)
    expect(category.name).to eq("playsuits")
    expect(category.female_only).to eq(true)
  end

  it 'should only have one name' do
    category = build(:category, :tees)
    expect(category.name).not_to eq("blouses")
  end

  it 'should downcase its name after saving' do
    name = category.name
    category.save
    expect(category.name).to eq(name.downcase)
  end

  it 'should be able to find its sub categories' do
    expect(category).to respond_to(:sub_categories)
  end
end
