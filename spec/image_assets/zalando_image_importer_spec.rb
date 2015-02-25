require 'rails_helper'

RSpec.describe "Zalando" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(ZalandoImageImporter.new.grab_image_url("www.test.com/@1", 3)).to eq("www.test.com/@3")
    end
end