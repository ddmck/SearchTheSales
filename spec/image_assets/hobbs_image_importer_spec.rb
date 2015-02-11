require 'rails_helper'

RSpec.describe "schuh" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(HobbsImageImporter.new.extract_images("www.test.com/_01_", 2)).to eq("www.test.com/_02_")
    end
end