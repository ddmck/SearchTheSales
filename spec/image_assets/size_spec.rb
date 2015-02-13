require 'rails_helper'
require 'size'

RSpec.describe "size" do
    it 'When url is sanitized it is sanitized correctly' do
      expect(Size.change_char_value("http://i1.adis.ws/i/jpl/sz_170041_a?w=370&h=415&qlt=80&unsharp=0,1,1,7&img404=sz_imagemissing", "b")).to eq("http://i1.adis.ws/i/jpl/sz_170041_b?w=370&h=415&qlt=80&unsharp=0,1,1,7&img404=sz_imagemissing")
      expect(Size.change_char_value("http://i1.adis.ws/i/jpl/sz_170041_a?w=370&h=415&qlt=80&unsharp=0,1,1,7&img404=sz_imagemissing", "c")).to eq("http://i1.adis.ws/i/jpl/sz_170041_c?w=370&h=415&qlt=80&unsharp=0,1,1,7&img404=sz_imagemissing")
    end
end