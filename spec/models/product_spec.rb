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
    product.category_setter(match_array)
    expect(product.category.name).to eq("shoes")
  end

  describe 'Category setter' do
    it 'Should not think Dresses are Jackets' do
      product = build(:product, name: "Floral Flouncy Slip Dress, Assorted")
      match_array = []
      match_array << product.name
      match_array << "Women's Dresses & Skirts".downcase #item[:category] placeholder
      product.category_setter(match_array)
      expect(product.category.name).to eq("dresses")
    end

    it 'Should know some Shoes' do
      product = build(:product, name: "Classic Slip On Women's Slip Ons (Shoes) In Dress Blue / White Checker")
      match_array = []
      match_array << product.name
      match_array << "Vans CLASSIC SLIP-ON women's Slip-ons (Shoes) in Dress Blue / White Checker Textile, Available in women's sizes. 11,12,5,6,7,9,11,12,5,6,7,9. Free Next Day Delivery and Free Returns on all orders!".downcase
      product.category_setter(match_array)
      expect(product.category.name).to eq("shoes")
    end

    it 'Should not think a Top is a Jacket' do
      product = build(:product, name: "Craft Print Box Tee, Pink")
      match_array = []
      match_array << product.name
      match_array << "Women's Tops".downcase
      product.category_setter(match_array)
      expect(product.category.name).to eq("tops")
    end

    it 'Should not think a Knitwear Jumper is a Jacket' do
      product = build(:product, name: "Brushed Turtle Neck Jumper, Turquoise")
      match_array = []
      match_array << product.name
      match_array << "knitwear" #not in datafeed anymore
      product.category_setter(match_array)
      expect(product.category.name).to eq("knitwear")
    end

    it 'Should not think a Skirt is a Jacket' do
      product = build(:product, name: "Etch Patterned Culottes In Mono, Black")
      match_array = []
      match_array << product.name
      match_array << "Women's Dresses & Skirts" #item[:category] placeholder
      product.category_setter(match_array)
      expect(product.category.name).to eq("skirts")
    end

    it 'Should not think a pair of Shoes is a Jacket' do
      product = build(:product, name: "Blazer Mid 'Metric' Qs")
      match_array = []
      match_array << "Footwear>Footwear".downcase #item[:category] placeholder
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("shoes")
    end

    it 'Should not think a top is a Jacket' do
      product = build(:product, name: "Flappa Intarsia Sweater, Black")
      match_array = []
      match_array << product.name
      match_array << "Women's Tops".downcase
      product.category_setter(match_array)
      expect(product.category.name).to eq("tops")
    end

    it 'Should think Tracksuit Bottoms are Trousers' do
      product = build(:product, name: "Aw77 Tracksuit Bottoms Dark Grey Heather")
      match_array = []
      match_array << "Men > Clothing > Trousers & Chinos > Joggers & Sweats".downcase
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("trousers")
    end

    it 'Should not think a Jersey is a Hoodie' do
      product = build(:product, name: "Men's Keldy Long Sleeve Jersey Sweat, Teal")
      match_array = []
      match_array << product.name # No longer exists in data feed
      product.category_setter(match_array)
      expect(product.category.name).to eq("polos")
    end

    it 'Should not think a Tee is a Hoodie' do
      product = build(:product, name: "Hador M Vador Graphic Print Cotton Vest, Purple")
      match_array = []
      match_array << "tees" # no longer exists in data feed
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("tees")
    end

    it 'Should not think a Tie is a pair of Jeans' do
      product = build(:product, name: "Marciano Tie Dark Jeans Blue")
      match_array = []
      match_array << "Men > Premium > Accessories > Ties & Accessories".downcase
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("accessories")
    end

    it 'Should not think a Pyjama top is a pair of Jeans' do
      product = build(:product, name: "Mix Program Pyjama Top")
      match_array = []
      match_array << "accessories" #Gone from data feed
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("accessories")
    end

    it 'Should not think a Beanie is a pair of shorts' do
      product = build(:product, name: "Short Watch Beanie")
      match_array = []
      match_array << "Accessories>Knitted Hats".downcase
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("accessories")
    end

    it 'Should not think a pair of boots is a pair of shorts' do
      product = build(:product, name: "Mens Original Biker Short Black Boots, Black")
      match_array = []
      match_array << product.name # no longer in data feed
      product.category_setter(match_array)
      expect(product.category.name).to eq("shoes")
    end

    it 'Should not think a tee is a pair of shorts' do
      product = build(:product, name: "Hockney Short Sleeved Knit")
      match_array = []
      match_array << "tees" # not in data feed anymore
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("tees")
    end

    it 'Should not think a Sweatshirt is a pair of shorts' do
      product = build(:product, name: "Flecked Short Sleeved Sweatshirt")
      match_array = []
      match_array << product.name # product not in feed
      product.category_setter(match_array)
      expect(product.category.name).to eq("sweats")
    end

    it 'Should not think a Jacket is a pair of shorts' do
      product = build(:product, name: "Short Coat Khaki")
      match_array = []
      match_array << "Men > Clothing > Coats > Short Coats"
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("jackets")
    end

    it 'Should not think a Top is a Jacket' do
      product = build(:product, name: "Woven Mix Raglan Top, Nude")
      match_array = []
      match_array << product.name
      match_array << "Women's Tops".downcase
      product.category_setter(match_array)
      expect(product.category.name).to eq("tops")
    end

    it 'Should not think a pair of Shorts is a Suit' do
      product = build(:product, name: "Berkley Suit Shorts In Navy, Navy")
      match_array = []
      match_array << "shorts" # no longer in data feed
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("shorts")
    end

    it 'Should not think a pair of Trunks are Swimming Trunks' do
      product = build(:product, name: "Three Pack Logo Waistband Trunks")
      match_array = []
      match_array << "Mens > Fashion / Leisure > Underwear".downcase
      match_array << product.name
      product.category_setter(match_array)
      expect(product.category.name).to eq("underwear")
    end
  end

  describe 'Gender Setter tests' do
    it 'Should know the difference between male and female' do
      product = build(:product, name: "Men's Logo Crew Neck Tshirt, Navy")
      match_array = []
      match_array << product.name
      product.gender_setter(match_array)
      expect(product.gender.name).to eq("male")
    end

    it 'Should know the difference between female and male' do
      product = build(:product, name: "Flappa Intarsia Sweater, Black")
      match_array = []
      match_array << "Women's Tops".downcase
      match_array << product.name
      product.gender_setter(match_array)
      expect(product.gender.name).to eq("female")
    end
  end

  describe 'Color Setter tests' do
    it 'Should know the colour black' do
      product = build(:product, name: "Flappa Intarsia Sweater, Black")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("black")
    end

    it 'Should know the colour purple' do
      product = build(:product, name: "Hador M Vador Graphic Print Cotton Vest, Purple")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("purple")
    end

    it 'Should know the colour pink' do
      product = build(:product, name: "Craft Print Box Tee, Pink")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("pink")
    end

    it 'Should know the colour grey' do
      product = build(:product, name: "6651 Women's Shoes (Trainers) In Grey")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("grey")
    end

    it 'Should know the colour brown' do
      product = build(:product, name: "Mes Women's Mid Boots In Brown")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("brown")
    end

    it 'Should know the colour beige' do
      product = build(:product, name: "Baltok Men's Casual Shoes In Beige")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("beige")
    end

    it 'Should know the colour yellow' do
      product = build(:product, name: "Tiger Corsair Vin Men's Shoes (Trainers) In Yellow / Blue")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("yellow")
    end

    it 'Should know the colour silver' do
      product = build(:product, name: "Frava Women's Shoes (Trainers) In Silver")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("silver")
    end

    it 'Should know the colour red' do
      product = build(:product, name: "Silvia Women's Shoes (High Top Trainers) In Red")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("red")
    end

    it 'Should know the colour orange' do
      product = build(:product, name: "Runner Backpack In Orange, Orange")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("orange")
    end

    it 'Should know the colour green' do
      product = build(:product, name: "Flashback Adjustable Boston Celtics Caps And Hats, Green")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("green")
    end

    it 'Should know the colour blue' do
      product = build(:product, name: "Mettler Men's Shoes (High Top Trainers) In Blue")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("blue")
    end

    it 'Should know the colour white' do
      product = build(:product, name: "Womens Major Elastic White Canvas Flats, White")
      match_array = []
      match_array << product.name
      product.color_setter(match_array)
      expect(product.color.name).to eq("white")
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
