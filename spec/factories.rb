FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foo#{n}" }
    password "foobar"
    password_confirmation "foobar"
    email { "#{username}@example.com" }
  end

  factory :store do
    name "MegaStore"
    url "http://megastore.com"
    image_url "http://megastore.com/image.png"
  end

  factory :brand do
    name "Levi"
    feature_text "Live in Levi's"
    image_url "http://levi.com/image.png"
  end

  factory :category do
    name "Jacket"
  end

  factory :product do 
    name "Jeans"
    description "You will look awesome!"
    url "http://jeans.com"
    image_url "http://jeans.com/image.png"
    gender "male"
    store
    brand
  end

  factory :color do
    name "Red"
  end

  factory :sub_category do
    name "Blazer"
    category
  end
end
