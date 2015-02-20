require 'rails_helper'

RSpec.describe "sarenza" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(SarenzaImageImporter.new.get_image_url("http://cdn.sarenza.net/static/_img/productsV4/0000029417/HD_0000029417_186958_09.jpg", 4)).to eq("http://cdn.sarenza.net/static/_img/productsV4/0000029417/HD_0000029417_186958_04.jpg")
    end
end