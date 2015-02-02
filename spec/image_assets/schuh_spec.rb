require 'rails_helper'
require 'schuh'

RSpec.describe "schuh" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(Schuh.main_to_zm("www.test.com/_main")).to eq("www.test.com/_zm")
      expect(Schuh.main_to_zm_numb("www.test.com/_main", 3)).to eq("www.test.com/m3_zm") 
    end
end