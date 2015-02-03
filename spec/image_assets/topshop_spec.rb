require 'rails_helper'
require 'topshop'

RSpec.describe "topshop" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(Topshop.normal_to_large("www.test.com/_normal")).to eq("www.test.com/_large")
      expect(Topshop.extract_images("www.test.com/_normal", 3)).to eq("www.test.com/_3_large") 
    end
end