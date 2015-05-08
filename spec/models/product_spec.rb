require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { build(:product) }
  let(:brand) { product.brand }
  let(:store) { product.store }
  let(:user) { build(:user) }

  it 'should not be valid without a name' do
    product.name = nil
    expect(product).to_not be_valid
  end

  # it 'should be valid without a brand_id' do
  #   product.brand_id = nil
  #   expect(product).to be_valid
  # end

  it 'should not be valid without a store_id' do
    product.store_id = nil
    expect(product).to_not be_valid
  end

  it 'should not be valid without a url' do
    product.url = nil
    expect(product).to_not be_valid
  end

  it 'should return its brand' do
    expect(product.brand).to eq(brand)
  end

  it 'should return its store' do
    expect(product.store).to eq(store)
  end

  it 'should know who has wished for it' do
    expect(product.wished_for_by).to be_empty
  end

  it 'should be able to find its category' do
    expect(product).to respond_to(:category)
  end

  it 'should be able to calculate a category' do
    product = build(:product, :shoes)
    match_array = []
    match_array << product.name
    cat = product.calc_category(match_array)
    expect(cat.name).to eq("shoes")
  end

  describe 'Category setter tests' do
    it 'Should not think Dresses are Jackets' do
      product = build(:product, name: "Floral Flouncy Slip Dress, Assorted")
      match_array = []
      match_array << product.name
      match_array << "dress" #item[:category] placeholder
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("dresses")
    end

    it 'Should not think a Tee is a Jacket' do
      product = build(:product, name: "Craft Print Box Tee, Pink")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("tees")
    end

    it 'Should not think a Knitwear Jumper is a Jacket' do
      product = build(:product, name: "Brushed Turtle Neck Jumper, Turquoise")
      match_array = []
      match_array << product.name
      match_array << "knitwear" #item[:category] placeholder
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("knitwear")
    end

    it 'Should not think a Skirt is a Jacket' do
      product = build(:product, name: "Etch Patterned Culottes In Mono, Black")
      match_array = []
      match_array << product.name
      match_array << "skirt" #item[:category] placeholder
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("skirts")
    end

    it 'Should not think a pair of Shoes is a Jacket' do
      product = build(:product, name: "Blazer Mid 'Metric' Qs")
      match_array = []
      match_array << "shoes" #item[:category] placeholder
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("shoes")
    end

    it 'Should not think a Sweater is a Jacket' do
      product = build(:product, name: "Flappa Intarsia Sweater, Black")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("sweats")
    end

    it 'Should not think Tracksuit Bottoms are Trousers' do
      product = build(:product, name: "Aw77 Tracksuit Bottoms Dark Grey Heather")
      match_array = []
      match_array << "shorts"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("shorts")
    end

    it 'Should not think a Sweatshirt is a Hoodie' do
      product = build(:product, name: "Men's Keldy Long Sleeve Jersey Sweat, Teal")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("sweats")
    end

    it 'Should not think a Tee is a Hoodie' do
      product = build(:product, name: "Hador M Vador Graphic Print Cotton Vest, Purplel")
      match_array = []
      match_array << "tees"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("tees")
    end

    it 'Should not think a Tie is a pair of Jeans' do
      product = build(:product, name: "Marciano Tie Dark Jeans Blue")
      match_array = []
      match_array << "accessories"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("accessories")
    end

    it 'Should not think a Pyjama top is a pair of Jeans' do
      product = build(:product, name: "Mix Program Pyjama Top Jeans")
      match_array = []
      match_array << "accessories"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("accessories")
    end

    it 'Should not think a Beanie is a pair of shorts' do
      product = build(:product, name: "Short Watch Beanie")
      match_array = []
      match_array << "accessories"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("accessories")
    end

    it 'Should not think a pair of boots is a pair of shorts' do
      product = build(:product, name: "Mens Original Biker Short Black Boots, Black")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("shoes")
    end

    it 'Should not think a tee is a pair of shorts' do
      product = build(:product, name: "Hockney Short Sleeved Knit")
      match_array = []
      match_array << "tees"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("tees")
    end

    it 'Should not think a Sweatshirt is a pair of shorts' do
      product = build(:product, name: "Flecked Short Sleeved Sweatshirt")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("sweats")
    end

    it 'Should not think a Jacket is a pair of shorts' do
      product = build(:product, name: "Short Coat Khaki")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("jackets")
    end

    it 'Should not think a Top is a Jacket' do
      product = build(:product, name: "Woven Mix Raglan Top, Nude")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("tops")
    end

    it 'Should not think a pair of Shorts is a Suit' do
      product = build(:product, name: "Berkley Suit Shorts In Navy, Navy")
      match_array = []
      match_array << "shorts"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("shorts")
    end

    it 'Should not think a pair of Trunks are Swimming Trunks' do
      product = build(:product, name: "Three Pack Logo Waistband Trunks")
      match_array = []
      match_array << "underwear"
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("underwear")
    end

    it 'Should not think a T-Shirt is Swimwear' do
      product = build(:product, name: "Men's Logo Crew Neck Tshirt, Navy")
      match_array = []
      match_array << product.name
      cat = product.calc_category(match_array)
      expect(cat.name).to eq("tees")
    end
  end

  it 'should be able to find its sub_category' do
    expect(product).to respond_to(:sub_category)
  end

  it 'should accept a sub category' do
    sub_category = build(:sub_category)
    product.sub_category = sub_category
    expect(product.sub_category).to eq(sub_category)
  end

  it 'should respond to trends' do
    expect(product).to respond_to(:trends)
  end

  it 'should accept trends' do
    trend = build(:trend)
    product.trends << trend
    expect(product.trends).to include(trend)
  end

  it "should respond to gender" do
    expect(product).to respond_to(:gender)
  end

  it "should be able to build a where hash for itself" do
    filters = {
      "category" => 1,
      "brand" => 1
    }
    result = product.build_where_hash(filters)
    desired = {
      category_id: 1,
      brand_id: 1
    }
    expect(result).to eq(desired)
  end

end
