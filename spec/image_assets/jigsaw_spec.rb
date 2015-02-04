require 'rails_helper'
require 'jigsaw'

RSpec.describe "Jigsaw" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(Jigsaw.grab_image_url("www.test.com/_1")).to eq("www.test.com/_2")
    end
end