require 'rails_helper'
require 'french_connection'

RSpec.describe "schuh" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(FrenchConnection.model_to_blank("www.test.com/_model")).to eq("www.test.com/")
      expect(FrenchConnection.model_to_numb("www.test.com/_model", 3)).to eq("www.test.com/_3") 
    end
end