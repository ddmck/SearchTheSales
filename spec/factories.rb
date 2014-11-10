FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foo#{n}" }
    password 'foobar'
    password_confirmation 'foobar'
    email { "#{username}@example.com" }
  end

  factory :store do
    sequence(:name) { |n| "store#{n}" }
    url 'http://megastore.com'
    image_url 'http://megastore.com/image.png'
  end

  factory :brand do
    sequence(:name) { |n| "brand#{n}" }
    feature_text "Live in Levi's"
    image_url 'http://levi.com/image.png'
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

  factory :product do
    sequence(:name) { |n| "product#{n}" }
    description 'You will look awesome!'
    sequence(:url, 9000) { |n| "http://www.url#{n}.com" }
    image_url 'http://jeans.com/image.png'
    gender 'male'
    store
    brand

    trait :with_sub_categories do
      after(:create) do |product|
        FactoryGirl.create_list(:sub_category, 1, product: product)
      end
    end
  end

  factory :color do
    sequence(:name) { |n| "color#{n}" }
  end

  factory :sub_category do
    sequence(:name) { |n| "subcat#{n}" }
    category
  end

  factory :trend do
    sequence(:name) { |n| "trend#{n}" }
  end

end
