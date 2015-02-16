require 'rails_helper'

RSpec.describe "john_lewis" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(JohnLewisImageImporter.new.grab_image_url("http://johnlewis.scene7.com/is/image/JohnLewis/001755843?$prod_main$", 1)).to eq("http://johnlewis.scene7.com/is/image/JohnLewis/001755843alt1?$prod_main$")
    end
end