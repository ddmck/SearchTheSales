require 'rails_helper'

RSpec.describe "schuh" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(FrenchConnectionImageImporter.new.model_to_blank("www.test.com/_model")).to eq("www.test.com/")
      expect(FrenchConnectionImageImporter.new.model_to_numb("www.test.com/_model", 3)).to eq("www.test.com/_3")
    end
end